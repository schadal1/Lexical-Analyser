# Lexical-Analyser
Specifications You will extend calc.l and calc.y  to parse and type check programs whose syntax is defined below. Prog ! main() {Stmts} Stmts ! ε | Stmt; Stmts  Stmt ! int Id | float Id | Id = E | printvar Id  E ! Integer | Float | Id | E + E | E * E  Integer ! digit+ Float -> Integer . Integer 


Stmts is a sequence of statements. Id is an identifier, which is a sequence of one or more lower-case letters or digits. Id should start with a lower-case letters.  For example, x, x1, xy are identifiers, but 1x and A are not.  Each variable is either a positive integer (int) or a positive floating point (float).   Expression E is an integer, a floating point, an identifier, or an infix arithmetic expression with operators "+" and “*” only. These two operators are left associative (e.g., 1 + 2 + 3 is equivalent to (1 + 2) + 3). “*" has higher precedence than “+”.   Id = E assigns the value of an expression E to the variable Id. printvar Id outputs the value of Id.  If there is any syntax error, you are expected to interpret the program until the statement where you find the error. Also, your error message must contain the line number where the error was found. Tokens  may be separated by any number of white spaces, tabs, or new lines.   Type checking rules are given below: Stmt -> int Id |               {Id.type = 0}               float Id |            {Id.type = 1}              Id = E                  {if (Id.type \= E.type) then type error} E ! Integer |                     {E.type = 0}          Float |                         {E.type = 1}         Id |                              {E.type = Id.type}         E1 + E2|                     {if (E1.type==E2.type) then E.type = E1.type; else type error}         E1 * E2 |                    {if (E1.type==E2.type) then E.type = E1.type; else type error} If one of the  aboverules is violated, your program should terminate and print “<line number>: type error”.  In addition, if a variable is used but is not declared, then your program should print “<line number>: <variable name> is used but is not declared”.    
Compile your program: 
flex –l calc.l bison -dv calc.y gcc -o calc calc.tab.c lex.yy.c –lfl 
Execution (example):. ./calc < input Where input is the name of the input file 

Names of members :   Rohan Reddy Bongurala
	 	     Ravi Teja Dupuguntla 
	 	     Sumanth Venkata Naga Satya Chadalla
Bmail id's of members :
	rbongur1@binghamton.edu
	schadal1@binghamton.edu
	rdupugu1@binghamton.edu

Respected Sir , 
My code was tested and had been run on bingsuns . 

To run the program : Use the make file to compile the calc.l and calc.y

