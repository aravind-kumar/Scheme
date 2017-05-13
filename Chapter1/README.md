# Chapter 1

## 1.1 Expressions
	
Anything which can be evaluated is an expression.

Ex: 329,425,x,y (where x and y are variables)

To operate on expressions scheme intakes inputs in the form on pre-fix notion.
 (<operator> <operand1> <operand2>..)
 Ex: (+ 2 3) = 5
 Where + is an operator, 2 and 3 are operands
 
The reason to choose prefix notion instead of infix notion is because
1.The can be any number of operands 
   Ex: (+ 2 3 4 5) = 14
2.They can be nested to any limit and can be solved without the need to use BODMASS rules.
   Ex: (+ 2 3 (* 4 5) (- 8 7))  
       = (+ 2 3 (20) (1))
       = 26
    The way to solve nested expressions to first start with inner-most expressions and branch out.

## Assign Values to variables
(define variable value)
Ex: (define a 23)
assigns a = 23.
where a is the variable and 23 is the value.

The variable reffereing to the value must be stored in a memory known as environment.

## Define Functions
(define (<function_name> arg1 arg2 ...) (<body>))
Ex:
(define (square x) (* x x))
(square 2) = 4
Notice the extra pair of brackets around the function name.
Although the keyword define is the same for both variable declaration and function declaration
The syntax is different. The function name and args are enclosed in brackets.


## Two modes of substition
1.Applicative order 
2.Normal order

Applicative order is the one where the function arguments are first fully evaluated before using them to on the body of the function
Normal order on the other hand doesnt evaluate the function arguments first but rather uses then on the function body first and then evaluates it.

Ex:
(square (+ 2 1)) (Applicative order)
(square (3))
(* 3 3) = 9
 
(square (+2 1)) (Normal order)
(* (+ 2 1) (+ 2 1))
(* (3) (3))  = 9 

When compared to applicative order normal order re-peforms the same evaluation multiple times.
Although applicative order is the one used by default for function evaluations there can be casses wherein normal order is also useful

## Coditionals
(cond ((expr1) (value1))
      ((expr2) (value2))
      ((expr3) (value3)))
Ex:
(cond (( < a 0) (a))
      (( > a 0) (+ a 1))
      (( = a 0) (0)))

cond is the keyword for conditions in scheme,
each pair of a condition and value are to be enclosed in brackets.
cond keyword is similar to if-elseif construct in other programming languages.
the expr1,expr2 .. are known as predicates which are functions which return either true or false.
The pair of ((expr) (value)) are known as clauses.

### If Else statement
(cond ((expr1) (value1))
       (else (value2)))
Ex:
(cond (( < a 0) (- a))
      (else a))
Similar to the first construct but instead of expr2 its replaced with else keyword

### If Else statement 2
(if (expr1) (value1) (value2))
Ex:
(if ( < a 0 ) ( - a) (a))

Where expr1 is the predicate which if evaulated to true returns value1 else value2
Notice unlike the cond statements the if statement does not require the expr-value pair to enclosed in brackets.

### Logical operator
1.and 
2.or
3.not






