let rules = {
    "A": { f: 1, t: true},
    "B": { f: 1, t: true},
    "C": { f: 1, t: true},
    "D": { f: 1, t: true},
    "E": { f: 1, t: true},
    "F": { f: 1, t: true},
    "G": { f: 1, t: true},
    "H": { f: 1, t: true},
    "I": { f: 1, t: true},
    "J": { f: 1, t: true},
    "K": { f: 1, t: true},
    "L": { f: 1, t: true},
    "M": { f: 1, t: true},
    "N": { f: 1, t: true},
    "O": { f: 1, t: true},
    "P": { f: 1, t: true},
    "Q": { f: 1, t: true},
    "R": { f: 1, t: true},
    "S": { f: 1, t: true},
    "T": { f: 1, t: true},
    "U": { f: 1, t: true},
    "V": { f: 1, t: true},
    "W": { f: 1, t: true},
    "X": { f: 1, t: true},
    "Y": { f: 1, t: true},
    "Z": { f: 1, t: true},
    "a": { f: 1, t: true},
    "b": { f: 1, t: true},
    "c": { f: 1, t: true},
    "d": { f: 1, t: true},
    "e": { f: 1, t: true},
    "f": { f: 1, t: true},
    "g": { f: 1, t: true},
    "h": { f: 1, t: true},
    "i": { f: 1, t: true},
    "j": { f: 1, t: true},
    "k": { f: 1, t: true},
    "l": { f: 1, t: true},
    "m": { f: 1, t: true},
    "n": { f: 1, t: true},
    "o": { f: 1, t: true},
    "p": { f: 1, t: true},
    "q": { f: 1, t: true},
    "r": { f: 1, t: true},
    "s": { f: 1, t: true},
    "t": { f: 1, t: true},
    "u": { f: 1, t: true},
    "v": { f: 1, t: true},
    "w": { f: 1, t: true},
    "x": { f: 1, t: true},
    "y": { f: 1, t: true},
    "z": { f: 1, t: true},

    "0": { f: 1, t: true},
    "1": { f: 1, t: true},
    "2": { f: 1, t: true},
    "3": { f: 1, t: true},
    "4": { f: 1, t: true},
    "5": { f: 1, t: true},
    "6": { f: 1, t: true},
    "7": { f: 1, t: true},
    "8": { f: 1, t: true},
    "9": { f: 1, t: true},

    "letter": {
        s: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"],
        p: "or",
        f: 1,
        t: false,
    },
    "digit": {
        s: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"],
        p: "or",
        f: 1,
        t: false,
    },
    "hexDigit": {
        s: ["digit", "A", "B", "C", "D", "E", "F"],
        p: "or",
        f: 1,
        t: false,
    },

    "qualident": {
        #s: [ident "."] ident,
    },
    "identdef": {
        #s: ident ["*"],
    },
    "integer": {
        #s: digit {digit} | digit {hexDigit} "H",
    },
    "real": {
        #s: digit {digit} "." {digit} [ScaleFactor],
    },
    "ScaleFactor": {
        #s: "E" ["+" | "-"] digit {digit},
    },
    "number": {
        #s: integer | real,
    },
    "string": {
        #s: """ {character} """ | digit {hexDigit} "X",
    },
    "ConstDeclaration": {
        #s: identdef "=" ConstExpression,
    },
    "ConstExpression": {
        #s: expression,
    },
    "TypeDeclaration": {
        #s: identdef "=" type,
    },
    "type": {
        #s: qualident | ArrayType | RecordType | PointerType | ProcedureType,
    },
    "ArrayType": {
        #s: ARRAY length {"," length} OF type,
    },
    "length": {
        #s: ConstExpression,
    },
    "RecordType": {
        #s: RECORD ["(" BaseType ")"] [FieldListSequence] END,
    },
    "BaseType": {
        #s: qualident,
    },
    "FieldListSequence": {
        #s: FieldList {";" FieldList},
    },
    "FieldList": {
        #s: IdentList ":" type,
    },
    "IdentList": {
        #s: identdef {"," identdef},
    },
    "PointerType": {
        #s: POINTER TO type,
    },
    "ProcedureType": {
        #s: PROCEDURE [FormalParameters],
    },
    "VariableDeclaration": {
        #s: IdentList ":" type,
    },
    "expression": {
        #s: SimpleExpression [relation SimpleExpression],
    },
    "relation": {
        #s: "=" | "#" | "<" | "<=" | ">" | ">=" | IN | IS,
    },
    "SimpleExpression": {
        #s: ["+" | "-"] term {AddOperator term},
    },
    "AddOperator": {
        #s: "+" | "-" | OR,
    },
    "term": {
        #s: factor {MulOperator factor},
    },
    "MulOperator": {
        #s: "*" | "/" | DIV | MOD | "&",
    },
    "factor": {
        #s: number | string | NIL | TRUE | FALSE | set | designator [ActualParameters] | "(" expression ")" | "~" factor,
    },
    "designator": {
        #s: qualident {selector},
    },
    "selector": {
        #s: "." ident | "[" ExpList "]" | "^" | "(" qualident ")",
    },
    "set": {
        #s: "{" [element {"," element}] "}",
    },
    "element": {
        #s: expression [".." expression],
    },
    "ExpList": {
        #s: expression {"," expression},
    },
    "ActualParameters": {
        #s: "(" [ExpList] ")",
    },
    "statement": {
        #s: [assignment | ProcedureCall | IfStatement | CaseStatement | WhileStatement | RepeatStatement | ForStatement],
    },
    "assignment": {
        #s: designator ":=" expression,
    },
    "ProcedureCall": {
        #s: designator [ActualParameters],
    },
    "StatementSequence": {
        #s: statement {";" statement},
    },
    "IfStatement": {
        #s: IF expression THEN StatementSequence {ELSIF expression THEN StatementSequence} [ELSE StatementSequence] END,
    },
    "CaseStatement": {
        #s: CASE expression OF case {"|" case} END,
    },
    "case": {
        #s: [CaseLabelList ":" StatementSequence],
    },
    "CaseLabelList": {
        #s: LabelRange {"," LabelRange},
    },
    "LabelRange": {
        #s: label [".." label],
    },
    "label": {
        #s: integer | string | qualident,
    },
    "WhileStatement": {
        #s: WHILE expression DO StatementSequence {ELSIF expression DO StatementSequence} END,
    },
    "RepeatStatement": {
        #s: REPEAT StatementSequence UNTIL expression,
    },
    "ForStatement": {
        #s: FOR ident ":=" expression TO expression [BY ConstExpression] DO StatementSequence END,
    },
    "ProcedureDeclaration": {
        #s: ProcedureHeading ";" ProcedureBody ident,
    },
    "ProcedureHeading": {
        #s: PROCEDURE identdef [FormalParameters],
    },
    "ProcedureBody": {
        #s: DeclarationSequence [BEGIN StatementSequence] [RETURN expression] END,
    },
    "DeclarationSequence": {
        #s: [CONST {ConstDeclaration ";"}] [TYPE {TypeDeclaration ";"}] [VAR {VariableDeclaration ";"}] {ProcedureDeclaration ";"},
    },
    "FormalParameters": {
        #s: "(" [FPSection {";" FPSection}] ")" [":" qualident],
    },
    "FPSection": {
        #s: [VAR] ident {"," ident} ":" FormalType,
    },
    "FormalType": {
        #s: {ARRAY OF} qualident,
    },
    "module": {
        #s: MODULE ident ";" [ImportList] DeclarationSequence [BEGIN StatementSequence] END ident ".",
    },
    "ImportList": {
        #s: IMPORT import {"," import} ";",
    },
    "import": {
        #s: ident [":=" ident],
    },
}
