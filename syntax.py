from typing import Any, Dict

import json
from pprint import pprint

SYNTAX_PATH = "syntax.json"
RULE_NAME = "string"


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


def main(*, syntax_path: str, rule_name: str):
    with open(syntax_path, "r") as syntax_file:
        syntax = json.load(syntax_file)["rules"]

    rule = generate_rule(rule_name, syntax=syntax[rule_name])
    print(f"'{RULE_NAME}' = '{rule}'")


if __name__ == "__main__":
    main(syntax_path=SYNTAX_PATH, rule_name=RULE_NAME)
