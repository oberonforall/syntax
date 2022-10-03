#!/usr/bin/env bash

rule_file="rules.txt"
syntax_file=".syntax.json"
reconstruction_file=".generated.txt"

# generate the files
nu syntax.nu > "$syntax_file"
echo "Syntax file generated at '$syntax_file'"

python syntax.py --all --path "$syntax_file" > "$reconstruction_file"
echo "Reconstructed file generated at '$reconstruction_file'"

vimdiff "$rule_file" "$reconstruction_file"
