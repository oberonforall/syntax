let rules = {
    "letter": {  # "A" | "B" | ... | "Z" | "a" | "b" | ... | "z"
        rules: [
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
        ],
        production: "or"
    },
    "digit": {  # "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
        rules: [
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
        ],
        production: "or"
    },
    "hexDigit": {  # digit | "A" | "B" | "C" | "D" | "E" | "F"
        rules: [
            "digit", "A", "B", "C", "D", "E", "F"
        ],
        production: "or"
    },
    "ident": {  # letter {letter | digit}
        rules: [
            "letter",
            {
                rules: [
                    {
                        rules: ["letter", "digit"],
                        production: "or"
                    }
                ],
                production: "any"
            }
        ],
        production: "seq"
    },
    "qualident": {  # [ident "."] ident
        rules: [
            {
                rules: [
                    {
                        rules: ["ident", "."],
                        production: "seq"
                    }
                ],
                production: "one"
            },
            "ident"
        ],
        production: "seq"
    }
    "identdef": {  # ident ["*"]
        rules: [
            "ident",
            {
                rules: ["*"],
                production: "one"
            }
        ],
        production: "seq"
    },
    "integer": {  # digit {digit} | digit {hexDigit} "H"
        rules: [
            {
                rules: [
                    "digit",
                    {
                        rules: ["digit"],
                        production: "any"
                    }
                ],
                production: "seq"
            },
            {
                rules: [
                    "digit",
                    {
                        rules: ["hexDigit"],
                        production: "any"
                    },
                    "H"
                ],
                production: "seq"
            },
        ],
        production: "or"
    },
    "real": {  # digit {digit} "." {digit} [ScaleFactor]
        rules: [
            "digit",
            {
                rules: ["digit"],
                production: "any"
            },
            ".",
            {
                rules: ["digit"],
                production: "any"
            },
            {
                rules: ["ScaleFactor"],
                production: "one"
            },
        ],
        production: "seq"
    },
    "ScaleFactor": {  # "E" ["+" | "-"] digit {digit}
        rules: [
            "E",
            {
                rules: [
                    {
                        rules: ["+", "-"],
                        production: "or"
                    }
                ],
                production: "one"
            },
            "digit",
            {
                rules: ["digit"],
                production: "any"
            }
        ],
        production: "seq"
    },
    "number": {  # integer | real
        rules: ["integer", "real"],
        production: "or"
    },
    "string": {  # """ {character} """ | digit {hexDigit} "X"
        rules: [
            {
                rules: [
                    "\"",
                    {
                        rules: ["character"],
                        production: "any"
                    },
                    "\""
                ],
                production: "seq"
            },
            {
                rules: [
                    "digit",
                    {
                        rules: ["hexDigit"],
                        production: "any"
                    },
                    "X"
                ],
                production: "seq"
            }
        ],
        production: "or"
    },
    "ConstDeclaration": {  # identdef "=" ConstExpression
        rules: ["identdef", "=", "ConstExpression"],
        production: "seq"
    },
    "ConstExpression": {  # expression
        rules: ["expression"],
        production: "seq"
    },
    "TypeDeclaration": {  # identdef "=" type
        rules: ["identdef", "=", "type"],
        production: "seq"
    },
    "type": {  # qualident | ArrayType | RecordType | PointerType | ProcedureType
        rules: ["qualident", "ArrayType", "RecordType", "PointerType", "ProcedureType"],
        production: "or"
    },
    "ArrayType": {  # ARRAY length {"," length} OF type
        rules: [
            "ARRAY",
            "length",
            {
                rules: [
                    {
                        rules: [",", "length"],
                        production: "seq"
                    }
                ],
                production: "any"
            },
            "OF",
            "type"
        ],
        production: "seq"
    },
    "length": {  # ConstExpression
        rules: ["ConstExpression"],
        production: "seq"
    },
    "RecordType": {  # RECORD ["(" BaseType ")"] [FieldListSequence] END
        rules: [
            "RECORD",
            {
                rules: [
                    {
                        rules: ["(", "BaseType", ")"],
                        production: "seq"
                    }
                ],
                production: "one"
            },
            {
                rules: ["FieldListSequence"],
                production: "one"
            },
            "END"
        ],
        production: "seq"
    },
    "BaseType": {  # qualident
        rules: ["qualident"],
        production: "seq"
    },
    "FieldListSequence": {  # FieldList {";" FieldList}
        rules: [
            "FieldList",
            {
                rules: [
                    {
                        rules: [";" "FieldList"],
                        production: "seq"
                    }
                ],
                production: "any"
            }
        ],
        production: "seq"
    },
    "FieldList": {  # IdentList ":" type
        rules: ["IdentList", ":", "type"],
        production: "seq"
    },
    "IdentList": {  # identdef {"," identdef}
        rules: [
            "identdef",
            {
                rules: [
                    {
                        rules: ["," "identdef"],
                        production: "seq"
                    }
                ],
                production: "any"
            }
        ],
        production: "seq"
    },
    "PointerType": {  # POINTER TO type
        rules: ["POINTER", "TO", "type"],
        production: "seq"
    },
    "ProcedureType": {  # PROCEDURE [FormalParameters]
        rules: [
            "PROCEDURE",
            {
                rules: ["FormalParameters"],
                production: "one"
            }
        ],
        production: "seq"
    },
    "VariableDeclaration": {  # IdentList ":" type
        rules: ["IdentList", ":", "type"],
        production: "seq"
    },
    "expression": {  # SimpleExpression [relation SimpleExpression]
        rules: [
            "SimpleExpression",
            {
                rules: [
                    {
                        rules: ["relation", "SimpleExpression"],
                        production: "seq"
                    }
                ],
                production: "one"
            }
        ],
        production: "seq"
    },
    "relation": {  # "=" | "#" | "<" | "<=" | ">" | ">=" | IN | IS
        rules: ["=", "#", "<", "<=", ">", ">=", "IN", "IS"],
        production: "or"
    },
    "SimpleExpression": {  # ["+" | "-"] term {AddOperator term}
        rules: [
            {
                rules: [
                    {
                        rules: ["+", "-"],
                        production: "or"
                    }
                ],
                production: "one"
            },
            "term",
            {
                rules: [
                    {
                        rules: ["AddOperator" "term"],
                        production: "seq"
                    }
                ],
                production: "any"
            }
        ],
        production: "seq"
    },
    "AddOperator": {  # "+" | "-" | OR
        rules: ["+", "-", "OR"],
        production: "or"
    },
    "term": {  # factor {MulOperator factor}
        rules: [
            "factor",
            {
                rules: [
                    {
                        rules: ["MulOperator" "factor"],
                        production: "seq"
                    }
                ],
                production: "any"
            }
        ],
        production: "seq"
    },
    "MulOperator": {  # "*" | "/" | DIV | MOD | "&"
        rules: ["*", "/", "DIV", "MOD", "&"],
        production: "or"
    },
    "factor": {  # number | string | NIL | TRUE | FALSE | set | designator [ActualParameters] | "(" expression ")" | "~" factor
        rules: [
            "number",
            "string",
            "NIL",
            "TRUE",
            "FALSE",
            "set",
            {
                rules: [
                    "designator",
                    {
                        rules: ["ActualParameters"],
                        production: "one"
                    }
                ],
                production: "seq"
            },
            {
                rules: ["(", "expression", ")"],
                production: "seq"
            },
            {
                rules: ["~", "factor"],
                production: "seq"
            }
        ],
        production: "or"
    },
    "designator": {  # qualident {selector}
        rules: [
            "qualident",
            {
                rules: ["selector"],
                production: "any"
            }
        ],
        production: "seq"
    },
    "selector": {  # "." ident | "[" ExpList "]" | "^" | "(" qualident ")"
        rules: [
            {
                rules: [".", "ident"],
                production: "seq"
            },
            {
                rules: ["[", "ExpList", "]"],
                production: "seq"
            },
            "^",
            {
                rules: ["(", "qualident", ")"],
                production: "seq"
            }
        ],
        production: "or"
    },
    "set": {  # "{" [element {"," element}] "}"
        rules: [
            "{",
            {
                rules: [
                    "element",
                    {
                        rules: [
                            {
                                rules: [",", "element"],
                                production: "seq"
                            }
                        ],
                        production: "any"
                    }
                ],
                production: "one"
            },
            "}"
        ],
        production: "seq"
    },
    "element": {  # expression [".." expression]
        rules: [
            "expression",
            {
                rules: [
                    {
                        rules: [".." "expression"],
                        production: "seq"
                    }
                ],
                production: "one"
            }
        ],
        production: "seq"
    },
    "ExpList": {  # expression {"," expression}
        rules: [
            "expression",
            {
                rules: [
                    {
                        rules: [",", "expression"],
                        production: "seq"
                    }
                ],
                production: "any"
            }
        ],
        production: "seq"
    },
    "ActualParameters": {  # "(" [ExpList] ")"
        rules: [
            "(",
            {
                rules: ["ExpList"],
                production: "one"
            },
            ")"
        ],
        production: "seq"
    },
    "statement": {  # [assignment | ProcedureCall | IfStatement | CaseStatement | WhileStatement | RepeatStatement | ForStatement]
        rules: [
            {
                rules: [
                    "assignment",
                    "ProcedureCall",
                    "IfStatement",
                    "CaseStatement",
                    "WhileStatement",
                    "RepeatStatement",
                    "ForStatement"
                ],
                production: "or"
            }
        ],
        production: "one"
    },
    "assignment": {  # designator ":=" expression
        rules: ["designator", ":=", "expression"],
        production: "seq"
    },
    "ProcedureCall": {  # designator [ActualParameters]
        rules: [
            "designator",
            {
                rules: ["ActualParameters"],
                production: "one"
            }
        ],
        production: "seq"
    },
    "StatementSequence": {  # statement {";" statement}
        rules: [
            "statement",
            {
                rules: [
                    {
                        rules: [";", "statement"],
                        production: "seq"
                    }
                ],
                production: "any"
            }
        ],
        production: "seq"
    },
    "IfStatement": {  # IF expression THEN StatementSequence {ELSIF expression THEN StatementSequence} [ELSE StatementSequence] END
        rules: [
            "IF",
            "expression",
            "THEN",
            "StatementSequence",
            {
                rules: [
                    {
                        rules: ["ELSIF", "expression", "THEN", "StatementSequence"],
                        production: "any"
                    },
                ],
                production: "any"
            },
            {
                rules: [
                    {
                        rules: ["ELSE", "StatementSequence"],
                        production: "any"
                    },
                ],
                production: "one"
            },
            "END"
        ],
        production: "seq"
    },
    "CaseStatement": {  # CASE expression OF case {"|" case} END
        rules: [
            "CASE",
            "expression",
            "OF",
            "case",
            {
                rules: [
                    {
                        rules: ["|", "case"],
                        production: "seq"
                    },
                ],
                production: "any"
            },
            "END"
        ],
        production: "seq"
    },
    "case": {  # [CaseLabelList ":" StatementSequence]
        rules: [
            {
                rules: ["CaseLabelList", ":", "StatementSequence"],
                production: "seq"
            }
        ],
        production: "one"
    },
    "CaseLabelList": {  # LabelRange {"," LabelRange}
        rules: [
            "LabelRange",
            {
                rules: [
                    {
                        rules: [",", "LabelRange"],
                        production: "seq"
                    }
                ],
                production: "any"
            }
        ],
        production: "seq"
    },
    "LabelRange": {  # label [".." label]
        rules: [
            "label",
            {
                rules: [
                    {
                        rules: ["..", "label"],
                        production: "seq"
                    }
                ],
                production: "one"
            }
        ],
        production: "seq"
    },
    "label": {  # integer | string | qualident
        rules: ["integer", "string", "qualident"],
        production: "or"
    },
    "WhileStatement": {  # WHILE expression DO StatementSequence {ELSIF expression DO StatementSequence} END
        rules: [
            "WHILE",
            "expression",
            "DO",
            "StatementSequence",
            {
                rules: [
                    {
                        rules: ["ELSIF", "expression", "DO", "StatementSequence"],
                        production: "seq"
                    }
                ],
                production: "any"
            },
            "END"
        ],
        production: "seq"
    },
    "RepeatStatement": {  # REPEAT StatementSequence UNTIL expression
        rules: ["REPEAT", "StatementSequence", "UNTIL", "expression"],
        production: "seq"
    },
    "ForStatement": {  # FOR ident ":=" expression TO expression [BY ConstExpression] DO StatementSequence END
        rules: [
            "FOR",
            "ident",
            ":=",
            "expression",
            "TO",
            "expression",
            {
                rules: [
                    {
                        rules: ["BY", "ConstExpression"],
                        production: "seq"
                    }
                ],
                production: "one"
            },
            "DO",
            "StatementSequence",
            "END"
        ],
        production: "seq"
    },
    "ProcedureDeclaration": {  # ProcedureHeading ";" ProcedureBody ident
        rules: ["ProcedureHeading", ";", "ProcedureBody", "ident"],
        production: "seq"
    },
    "ProcedureHeading": {  # PROCEDURE identdef [FormalParameters]
        rules: [
            "PROCEDURE",
            "identdef",
            {
                rules: ["FormalParameters"],
                production: "one"
            }
        ],
        production: "seq"
    },
    "ProcedureBody": {  # DeclarationSequence [BEGIN StatementSequence] [RETURN expression] END
        rules: [
            "DeclarationSequence",
            {
                rules:
                    {
                        rules: ["BEGIN", "StatementSequence"],
                        production: "seq"
                    }
                ],
                production: "one"
            },
            {
                rules:
                    {
                        rules: ["RETURN", "expression"],
                        production: "seq"
                    }
                ],
                production: "one"
            },
            "END"
        ],
        production: "seq"
    },
    "DeclarationSequence": {  # [CONST {ConstDeclaration ";"}] [TYPE {TypeDeclaration ";"}] [VAR {VariableDeclaration ";"}] {ProcedureDeclaration ";"}
        rules: [
            {
                rules: [
                    {
                        rules: [
                            "CONST",
                            {
                                rules: [
                                    {
                                        rules: ["ConstDeclaration", ";"],
                                        production: "seq"
                                    }
                                ],
                                production: "any"
                            }
                        ],
                        production: "seq"
                    }
                ],
                production: "one"
            },
            {
                rules: [
                    {
                        rules: [
                            "TYPE",
                            {
                                rules: [
                                    {
                                        rules: ["TypeDeclaration", ";"],
                                        production: "seq"
                                    }
                                ],
                                production: "any"
                            }
                        ],
                        production: "seq"
                    }
                ],
                production: "one"
            },
            {
                rules: [
                    {
                        rules: [
                            "VAR",
                            {
                                rules: [
                                    {
                                        rules: ["VariableDeclaration", ";"],
                                        production: "seq"
                                    }
                                ],
                                production: "any"
                            }
                        ],
                        production: "seq"
                    }
                ],
                production: "one"
            },
            {
                rules: [
                    {
                        rules: ["ProcedureDeclaration", ";"],
                        production: "seq"
                    }
                ],
                production: "any"
            }
        ],
        production: "seq"
    },
    "FormalParameters": {  # "(" [FPSection {";" FPSection}] ")" [":" qualident]
        rules: [
            "(",
            {
                rules: [
                    {
                        rules: [
                            "FPSection",
                            {
                                rules: [";" "FPSection"],
                                production: "any"
                            }
                        ],
                        production: "seq"
                    }
                ],
                production: "one"
            }
            ")",
            {
                rules: [
                    {
                        rules: [":", "qualident"],
                        production: "seq"
                    }
                ],
                production: "one"
            }
        ],
        production: "seq"
    },
    "FPSection": {  # [VAR] ident {"," ident} ":" FormalType
        rules: [
            {
                rules: ["VAR"],
                production: "one"
            },
            "ident",
            {
                rules: [
                    {
                        rules: [",", "ident"],
                        production: "seq"
                    }
                ],
                production: "any"
            },
            ":",
            "FormalType"
        ],
        production: "seq"
    },
    "FormalType": {  # {ARRAY OF} qualident
        rules: [
            {
                rules: [
                    {
                        rules: ["ARRAY", "OF"],
                        production: "seq"
                    }
                ],
                production: "any"
            },
            "qualident"
        ],
        production: "seq"
    },
    "module": {  # MODULE ident ";" [ImportList] DeclarationSequence [BEGIN StatementSequence] END ident "."
        rules: [
            "MODULE",
            "ident",
            ";",
            {
                rules: ["ImportList"],
                production: "one"
            }
            "DeclarationSequence",
            {
                rules: [
                    {
                        rules: ["BEGIN", "StatementSequence"],
                        production: "seq"
                    }
                ],
                production: "one"
            }
            "END",
            "ident",
            "."
        ],
        production: "seq"
    },
    "ImportList": {  # IMPORT import {"," import} ";"
        rules: [
            "IMPORT",
            "import",
            {
                rules: [
                    {
                        rules: [",", "import"],
                        production: "seq"
                    }
                ],
                production: "any"
            },
            ";"
        ],
        production: "seq"
    },
    "import": {  # ident [":=" ident]
        rules: [
            "ident",
            {
                rules: [
                    {
                        rules: [":=", "ident"],
                        production: "seq"
                    }
                ],
                production: "one"
            }
        ],
        production: "seq"
   }
}
