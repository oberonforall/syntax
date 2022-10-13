#!/usr/bin/env python

from typing import Any, Dict, List
import argparse

import csv
import logging
import os
import shutil
import json


def copy_index(website_path: str, template_path: str):
    logging.info("Copying the index.html file...")
    os.makedirs(website_path, exist_ok=True)

    src_index = os.path.join(template_path, "index.html")
    dst_index = os.path.join(website_path, "index.html")
    shutil.copy(src_index, dst_index)


def is_keyword(word: str) -> bool:
    return len(word) >= 2 and word.isupper()


def multiline_find_replace(
    lines: List[str],
    find: str,
    replace: List[str]
) -> List[str]:
    indices = [i for i, line in enumerate(lines) if find in line]
    if len(indices) != 1:
        return None

    index = indices[0]

    for repl in replace[::-1]:
        line = lines[index].replace(find, repl)
        lines.insert(index + 1, line)
    lines.pop(index)

    return lines


def get_keywords(syntax: Dict[str, Any]) -> List[str]:
    def aux(syntax: Dict[str, Any]):
        rules = syntax["rules"]

        keywords = []
        for rule in rules:
            if isinstance(rule, str):
                if is_keyword(rule):
                    keywords.append(rule)
            elif isinstance(rule, Dict):
                keywords += aux(rule)

        return keywords

    keywords = []
    for key, value in syntax.items():
        keywords += aux(value)
    return sorted(list(set(keywords)))


def generate_keywords(keywords: List[str], back_references: Dict[str, List[str]], website_path: str, template_path: str):
    logging.info("Generating the keywords...")

    keywords_path = os.path.join(website_path, "keywords")
    os.makedirs(keywords_path, exist_ok=True)

    src_file = os.path.join(template_path, "keywords", "keyword.html")
    for keyword in keywords:
        # copy the template file
        dst_file = os.path.join(keywords_path, f"{keyword}.html")
        shutil.copy(src_file, dst_file)

        # read the copied template file
        with open(dst_file, "r") as keyword_file:
            keyword_html = keyword_file.read()
            keyword_html = keyword_html.replace("{{KEYWORD}}", keyword)

            find = "{{REFERENCE}}"
            lines = multiline_find_replace(
                keyword_html.split("\n"),
                find=find,
                replace=back_references[keyword],
            )
            assert lines is not None, f"There should be only one {find} in {src_file}!"

        # write the final file
        with open(dst_file, "w") as keyword_file:
            keyword_file.write("\n".join(lines))


def generate_rules(rules: List[str], website_path: str, template_path: str):
    logging.info("Generating the rules...")

    rules_path = os.path.join(website_path, "rules")
    os.makedirs(rules_path, exist_ok=True)

    src_file = os.path.join(template_path, "rules", "rule.html")
    for rule in rules:
        dst_file = os.path.join(rules_path, f"{rule}.html")
        shutil.copy(src_file, dst_file)


def generate_builtins(website_path: str, template_path: str):
    logging.info("Generating the builtins...")

    builtins_path = os.path.join(website_path, "builtins")
    os.makedirs(builtins_path, exist_ok=True)

    types = [
        ("regular", "functions", "regular-function"),
        ("regular", "procedures", "regular-procedure"),
        ("system", "functions", "system-function"),
        ("system", "procedures", "system-procedure")
    ]
    for top_dir, sub_dir, name in types:
        src_file = os.path.join(
            template_path,
            "builtins",
            top_dir,
            sub_dir,
            f"{name}.html"
        )

        builins_filename = os.path.join(
            "res",
            "builtins",
            top_dir,
            f"{sub_dir}.csv"
        )
        builtins_data = []
        line_count = 0
        with open(builins_filename, "r") as builtins_file:
            builtins_csv = csv.reader(builtins_file, delimiter=',')
            for row in builtins_csv:
                if line_count >= 1:
                    builtins_data.append(row)
                line_count += 1

        dst_dir = os.path.join(
            builtins_path,
            top_dir,
            sub_dir
        )
        os.makedirs(dst_dir, exist_ok=True)
        for name, *types, description in builtins_data:
            # copy the template
            dst_file = os.path.join(dst_dir, f"{name}.html")
            shutil.copy(src_file, dst_file)

            # read the copied template file
            with open(dst_file, "r") as builtin_file:
                builtin_html = builtin_file.read()
                builtin_html = builtin_html.replace("{{PROCEDURE}}", name)

                find = "{{DESCRIPTION}}"
                lines = multiline_find_replace(
                    builtin_html.split("\n"),
                    find=find,
                    replace=description.split("\\n"),
                )
                assert lines is not None, f"There should be only one {find} in {src_file}!"

                find = "{{SIMILAR}}"
                lines = multiline_find_replace(
                    lines,
                    find=find,
                    replace=[similar_name for similar_name, *_ in builtins_data if similar_name != name],
                )
                assert lines is not None, f"There should be only one {find} in {src_file}!"

            # write the final file
            with open(dst_file, "w") as builtin_file:
                builtin_file.write("\n".join(lines))


def get_back_references(syntax: Dict[str, Any]) -> Dict[str, List[str]]:
    def aux(syntax: Dict[str, Any]):
        rules = syntax["rules"]

        references = []
        for rule in rules:
            if isinstance(rule, str):
                references.append(rule)
            elif isinstance(rule, Dict):
                for reference in aux(rule):
                    references.append(reference)

        return references

    references = {}
    for key, value in syntax.items():
        references[key] = aux(value)

    back_references = {}
    for key, value in references.items():
        for reference in value:
            if reference not in back_references:
                back_references[reference] = []
            back_references[reference].append(key)

    for key, value in back_references.items():
        back_references[key] = sorted(list(set(value)))

    return back_references


def main(*, syntax_path: str, website_path: str, template_path: str):
    with open(syntax_path, "r") as syntax_file:
        syntax = json.load(syntax_file)["rules"]

    keywords = get_keywords(syntax)
    rules = list(syntax.keys())
    back_references = get_back_references(syntax)

    copy_index(website_path=website_path, template_path=template_path)
    generate_keywords(keywords, back_references, website_path=website_path, template_path=template_path)
    generate_rules(rules, website_path=website_path, template_path=template_path)
    generate_builtins(website_path=website_path, template_path=template_path)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    default = "syntax.json"
    parser.add_argument(
        "--path",
        "-p",
        type=str,
        default=default,
        help=f"the path to the syntax file (defaults to {default}).",
    )
    default = "website"
    parser.add_argument(
        "--website",
        "-w",
        type=str,
        default=default,
        help=f"the path to the generated HTML website files (defaults to {default}).",
    )
    default = "res/html/templates"
    parser.add_argument(
        "--templates",
        "-t",
        type=str,
        default=default,
        help=f"the path to the HTML template files (defaults to {default}).",
    )

    args = parser.parse_args()

    logging.basicConfig(
        level=logging.DEBUG,
        format="[%(levelname)s] %(message)s"
    )

    main(
        syntax_path=args.path,
        website_path=args.website,
        template_path=args.templates,
    )
