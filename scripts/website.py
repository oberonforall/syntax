#!/usr/bin/env python

from typing import Any, Dict, List
import argparse

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


def get_keywords(syntax: Dict[str, Any]) -> List[str]:
    def aux(syntax: Dict[str, Any]):
        rules = syntax["rules"]

        keywords = []
        for rule in rules:
            if isinstance(rule, str):
                if is_keyword(rule):
                    keywords.append(rule)
            elif isinstance(rule, Dict):
                for keyword in aux(rule):
                    keywords.append(keyword)

        return keywords

    keywords = []
    for key, value in syntax.items():
        keywords += aux(value)
    return sorted(list(set(keywords)))


def generate_keywords(syntax: Dict[str, Any], website_path: str, template_path: str):
    logging.info("Generating the keywords...")
    keywords = get_keywords(syntax)

    keywords_path = os.path.join(website_path, "keywords")
    os.makedirs(keywords_path, exist_ok=True)

    src_file = os.path.join(template_path, "keywords", "keyword.html")
    for keyword in keywords:
        dst_file = os.path.join(keywords_path, f"{keyword}.html")
        shutil.copy(src_file, dst_file)


def generate_rules(syntax: Dict[str, Any], website_path: str, template_path: str):
    logging.info("Generating the rules...")

    rules_path = os.path.join(website_path, "rules")
    os.makedirs(rules_path, exist_ok=True)

    src_file = os.path.join(template_path, "rules", "rule.html")
    for rule in syntax.keys():
        dst_file = os.path.join(rules_path, f"{rule}.html")
        shutil.copy(src_file, dst_file)


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

    copy_index(website_path=website_path, template_path=template_path)
    generate_keywords(syntax, website_path=website_path, template_path=template_path)
    generate_rules(syntax, website_path=website_path, template_path=template_path)


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
