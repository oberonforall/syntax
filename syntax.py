from typing import Any, Dict

import json
from pprint import pprint

SYNTAX_PATH = "syntax.json"
RULE_NAME = "letter"


def generate_rule(name: str, *, syntax: Dict[str, Any]) -> str:
    return "TODO"


def main(*, syntax_path: str, rule_name: str):
    with open(syntax_path, "r") as syntax_file:
        syntax = json.load(syntax_file)

    rule = generate_rule(rule_name, syntax=syntax)
    print(f"'{RULE_NAME}' = '{rule}'")


if __name__ == "__main__":
    main(syntax_path=SYNTAX_PATH, rule_name=RULE_NAME)
