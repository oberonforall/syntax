import json
from pprint import pprint


RULES_PATH = "rules.json"


def main():
    with open(RULES_PATH, "r") as rules_file:
        rules = json.load(rules_file)

    pprint(rules)


if __name__ == "__main__":
    main()
