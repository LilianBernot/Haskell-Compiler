sh> make compile
sh> make test_00.ex
sh> make clean 

# Use the parser

Here is a quick overview of the features of the parser. You can find some use cases in the test_xxx.p files.

## Commenting

You can comment code with : 
- ```--``` : comment a line
- ```{-- Your code --}``` : comment multiple lines

## Mathematics

You have the basics operations : ``` + ```, ``` - ```, ``` * ```, ``` / ```, ``` ** ```, ``` % ``` (modulo)

## While loops

You can define while llops with the following syntax : ``` while (codition) { code to execute } ```.

## If, then, else statement

You can define if, then, else statement with this syntax : ``` if (condition) { code then } else { code else } ```.

## Variables

You can define variables in a few ways : 
- ``` var a, b, c; ``` : var is a keyword here
- ``` var myvar = value; ``` : you can directly define variables and assigning them values
- ``` var myvar = value; ``` : you don't even need to specify the 'var' keyword if you give your variable a value

## Arrays 

You can define arrys like this : ``` array myArray length; ``` where 'array' is a keyword and 'length' is the number of elements to give to your array.

You can then querry and add values to your array like : ``` arr[2] = 17; print arr[1+1]; ```

## Ask for user input

You can ask for the user to input a value like : ``` input yourVariable; ```. The value entered by the user will be stored in the 'yourVariable' variable. You have to declare this variable before calling it. A complete use case would be : ``` var yourVariable; input yourVariable; print yourVariable;```

## Comparation operators

You can use the following comparisons : ``` > ```, ``` >= ```, ``` < ```, ``` <= ```, ``` == ```, ``` != ```.

## Logical operators 

The compiler has boolean types where ``` 1 ``` represents True and ``` 0 ``` False (in reallity, False is everything but 1). You can use the following logical operators on any expressions : ``` and ```, ``` or ```, ``` not ```.

## Functions

You can define functions without arguments like that : ``` def myFunction() { code }; ```.

DRAFT : last commit is a draft for making functions accept arguments. Ignore it if you want to run the code about functions properly.

## System function calls

You can call ``` exit(number) ``` to make code stop with number on top of the pile.