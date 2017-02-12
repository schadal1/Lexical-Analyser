# Lexical-Analyser
Specifications You will extend calc.l and calc.y  to parse and type check programs whose syntax is defined below. Prog ! main() {Stmts} Stmts ! ε | Stmt; Stmts  Stmt ! int Id | float Id | Id = E | printvar Id  E ! Integer | Float | Id | E + E | E * E  Integer ! digit+ Float -> Integer . Integer 
