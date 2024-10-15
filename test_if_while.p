-- If else statements
if (2 > 2) { 
    print 888888; 
} else {
    print 22222;
}

if (2 == 2) { 
    print 888888; 
}

-- Basic while statement
var reducer = 3;
while reducer {
    print reducer;
    reducer = reducer - 1;
};

-- Euclide algorithm
var a;
input a;
var b;
input b;
while (b != 0) {
    var remainder = a % b;
    a = b;
    b = remainder;
}
print a;