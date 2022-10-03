from typing import Any, Dict, List
import argparse

import json


def generate_rule(name: str, *, syntax: Dict[str, Any]) -> str:
    production = syntax["production"]
    rules = syntax["rules"]

    produced_rules = []
    for rule in rules:
        if isinstance(rule, str):
            produced_rules.append(rule)
        elif isinstance(rule, Dict):
            produced_rules.append(generate_rule(rule, syntax=rule))

    if production == "or":
        rule = " | ".join(produced_rules)
    elif production == "any":
        inner = " ".join(produced_rules)
        rule = "{ %s }" % inner
    elif production == "one":
        inner = " ".join(produced_rules)
        rule = f"[ {inner} ]"
    elif production == "seq":
        rule = " ".join(produced_rules)
    else:
        raise ValueError(f"Unknown production rule '{production}'")

    return rule


def main(*, syntax_path: str, rule_names: List[str], generate_all: bool):
    with open(syntax_path, "r") as syntax_file:
        syntax = json.load(syntax_file)["rules"]

    syntax_tokens = list(syntax.keys())

    if generate_all:
        rule_names = sorted(syntax_tokens)

    for rule_name in rule_names:
        if rule_name in syntax_tokens:
            rule = generate_rule(rule_name, syntax=syntax[rule_name])
            print(f"{rule_name} = {rule}")
        else:
            print(f"'{rule_name}' is not a valid token for syntax at '{syntax_path}")


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
    parser.add_argument(
        "--rules",
        "-r",
        type=str,
        nargs="+",
        help="the list of rules to generate.",
    )
    parser.add_argument(
        "--all",
        "-a",
        action="store_true",
        help="generates all syntax rules (overwrites --rules).",
    )

    args = parser.parse_args()

    if args.rules is None and not args.all:
        print("No rules were provided...")
        print("Terminating.")
        exit(1)

    main(
        syntax_path=args.path,
        rule_names=sorted(args.rules) if not args.all else None,
        generate_all=args.all,
    )
