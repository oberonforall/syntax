#!/usr/bin/env bash

# generate the files
nu syntax.nu > .syntax.json
python syntax.py --all --path .syntax.json > .generated.txt

vimdiff rules.txt .generated.txt
