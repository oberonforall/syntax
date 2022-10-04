#!/usr/bin/env bash

rule_file="./res/rules.txt"
syntax_file=".syntax.json"
reconstruction_file=".generated.txt"

# generate the files
./scripts/syntax.nu > "$syntax_file"
echo "Syntax file generated at '$syntax_file'"

./scripts/syntax.py --all --path "$syntax_file" > "$reconstruction_file"
echo "Reconstructed file generated at '$reconstruction_file'"

vimdiff "$rule_file" "$reconstruction_file"
