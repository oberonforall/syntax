from typing import Any, Dict

import json
from pprint import pprint

RULES_PATH = "rules.json"
RULE_NAME = "letter"


def generate_rule(name: str, *, rules: Dict[str, Any]) -> str:
    return "TODO"


def main(*, rules_path: str, rule_name: str):
    with open(rules_path, "r") as rules_file:
        rules = json.load(rules_file)

    rule = generate_rule(rule_name, rules=rules)
    print(f"'{RULE_NAME}' = '{rule}'")


if __name__ == "__main__":
    main(rules_path=RULES_PATH, rule_name=RULE_NAME)
