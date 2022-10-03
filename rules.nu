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
        ],
        production: "foo"
    },
    "ConstDeclaration": {  # identdef "=" ConstExpression
        rules: [
        ],
        production: "foo"
    },
    "ConstExpression": {  # expression
        rules: [
        ],
        production: "foo"
    },
    "TypeDeclaration": {  # identdef "=" type
        rules: [
        ],
        production: "foo"
    },
    "type": {  # qualident | ArrayType | RecordType | PointerType | ProcedureType
        rules: [
        ],
        production: "foo"
    },
    "ArrayType": {  # ARRAY length {"," length} OF type
        rules: [
        ],
        production: "foo"
    },
    "length": {  # ConstExpression
        rules: [
        ],
        production: "foo"
    },
    "RecordType": {  # RECORD ["(" BaseType ")"] [FieldListSequence] END
        rules: [
        ],
        production: "foo"
    },
    "BaseType": {  # qualident
        rules: [
        ],
        production: "foo"
    },
    "FieldListSequence": {  # FieldList {";" FieldList}
        rules: [
        ],
        production: "foo"
    },
    "FieldList": {  # IdentList ":" type
        rules: [
        ],
        production: "foo"
    },
    "IdentList": {  # identdef {"," identdef}
        rules: [
        ],
        production: "foo"
    },
    "PointerType": {  # POINTER TO type
        rules: [
        ],
        production: "foo"
    },
    "ProcedureType": {  # PROCEDURE [FormalParameters]
        rules: [
        ],
        production: "foo"
    },
    "VariableDeclaration": {  # IdentList ":" type
        rules: [
        ],
        production: "foo"
    },
    "expression": {  # SimpleExpression [relation SimpleExpression]
        rules: [
        ],
        production: "foo"
    },
    "relation": {  # "=" | "#" | "<" | "<=" | ">" | ">=" | IN | IS
        rules: [
        ],
        production: "foo"
    },
    "SimpleExpression": {  # ["+" | "-"] term {AddOperator term}
        rules: [
        ],
        production: "foo"
    },
    "AddOperator": {  # "+" | "-" | OR
        rules: [
        ],
        production: "foo"
    },
    "term": {  # factor {MulOperator factor}
        rules: [
        ],
        production: "foo"
    },
    "MulOperator": {  # "*" | "/" | DIV | MOD | "&"
        rules: [
        ],
        production: "foo"
    },
    "factor": {  # number | string | NIL | TRUE | FALSE | set | designator [ActualParameters] | "(" expression ")" | "~" factor
        rules: [
        ],
        production: "foo"
    },
    "designator": {  # qualident {selector}
        rules: [
        ],
        production: "foo"
    },
    "selector": {  # "." ident | "[" ExpList "]" | "^" | "(" qualident ")"
        rules: [
        ],
        production: "foo"
    },
    "set": {  # "{" [element {"," element}] "}"
        rules: [
        ],
        production: "foo"
    },
    "element": {  # expression [".." expression]
        rules: [
        ],
        production: "foo"
    },
    "ExpList": {  # expression {"," expression}
        rules: [
        ],
        production: "foo"
    },
    "ActualParameters": {  # "(" [ExpList] ")"
        rules: [
        ],
        production: "foo"
    },
    "statement": {  # [assignment | ProcedureCall | IfStatement | CaseStatement | WhileStatement | RepeatStatement | ForStatement]
        rules: [
        ],
        production: "foo"
    },
    "assignment": {  # designator ":=" expression
        rules: [
        ],
        production: "foo"
    },
    "ProcedureCall": {  # designator [ActualParameters]
        rules: [
        ],
        production: "foo"
    },
    "StatementSequence": {  # statement {";" statement}
        rules: [
        ],
        production: "foo"
    },
    "IfStatement": {  # IF expression THEN StatementSequence {ELSIF expression THEN StatementSequence} [ELSE StatementSequence] END
        rules: [
        ],
        production: "foo"
    },
    "CaseStatement": {  # CASE expression OF case {"|" case} END
    },
    "case": {  # [CaseLabelList ":" StatementSequence]
        rules: [
        ],
        production: "foo"
    },
    "CaseLabelList": {  # LabelRange {"," LabelRange}
        rules: [
        ],
        production: "foo"
    },
    "LabelRange": {  # label [".." label]
        rules: [
        ],
        production: "foo"
    },
    "label": {  # integer | string | qualident
        rules: [
        ],
        production: "foo"
    },
    "WhileStatement": {  # WHILE expression DO StatementSequence {ELSIF expression DO StatementSequence} END
        rules: [
        ],
        production: "foo"
    },
    "RepeatStatement": {  # REPEAT StatementSequence UNTIL expression
        rules: [
        ],
        production: "foo"
    },
    "ForStatement": {  # FOR ident ":=" expression TO expression [BY ConstExpression] DO StatementSequence END
        rules: [
        ],
        production: "foo"
    },
    "ProcedureDeclaration": {  # ProcedureHeading ";" ProcedureBody ident
        rules: [
        ],
        production: "foo"
    },
    "ProcedureHeading": {  # PROCEDURE identdef [FormalParameters]
        rules: [
        ],
        production: "foo"
    },
    "ProcedureBody": {  # DeclarationSequence [BEGIN StatementSequence] [RETURN expression] END
        rules: [
        ],
        production: "foo"
    },
    "DeclarationSequence": {  # [CONST {ConstDeclaration ";"}] [TYPE {TypeDeclaration ";"}] [VAR {VariableDeclaration ";"}] {ProcedureDeclaration ";"}
        rules: [
        ],
        production: "foo"
    },
    "FormalParameters": {  # "(" [FPSection {";" FPSection}] ")" [":" qualident]
        rules: [
        ],
        production: "foo"
    },
    "FPSection": {  # [VAR] ident {"," ident} ":" FormalType
        rules: [
        ],
        production: "foo"
    },
    "FormalType": {  # {ARRAY OF} qualident
        rules: [
        ],
        production: "foo"
    },
    "module": {  # MODULE ident ";" [ImportList] DeclarationSequence [BEGIN StatementSequence] END ident "."
        rules: [
        ],
        production: "foo"
    },
    "ImportList": {  # IMPORT import {"," import} ";"
        rules: [
        ],
        production: "foo"
    },
    "import": {  # ident [":=" ident]
        rules: [
        ],
        production: "foo"
   }
}
