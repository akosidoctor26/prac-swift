//
//  Enumeration.swift
//  
//
//  Created by Kristine Doc on 7/16/26.
//


// Swift enumeration cases don’t have an integer value set by default, unlike languages like C and Objective-C. In the CompassPoint example above, north, south, east and west don’t implicitly equal 0, 1, 2 and 3. Instead, the different enumeration cases are values in their own right, with an explicitly defined type of CompassPoint.
enum CompassPoint: CaseIterable {
    case north
    case east
    case south
    case west
    
    // or one line
    // case north, east, west, south
}


var direction = CompassPoint.north
// The type of directionToHead is inferred when it’s initialized with one of the possible values of CompassPoint. Once directionToHead is declared as a CompassPoint, you can set it to a different CompassPoint value using a shorter dot syntax:
direction = .east

// Iterating over Enumeration Cases
// For some enumerations, it’s useful to have a collection of all of that enumeration’s cases. You enable this by writing : CaseIterable after the enumeration’s name. Swift exposes a collection of all the cases as an allCases property of the enumeration type. Here’s an example:
print(CompassPoint.allCases.count)

for direction in CompassPoint.allCases {
    print(direction)
}

// Associated Values
// it’s sometimes useful to be able to store values of other types alongside these case values. This additional information is called an associated value, and it varies each time you use that case as a value in your code.
enum Barcode {
    // This can be read as:
    // “Define an enumeration type called Barcode, which can take either a value of upc with an associated value of type (Int, Int, Int, Int), or a value of qrCode with an associated value of type String.”
    
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

//var productBarcode = Barcode.upc(4,3,2,1)
var productBarcode = Barcode.qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case let .upc( ns,  man,  prod,  check): // one let
    print("UPC: \(ns), \(man), \(prod), \(check)")

case .qrCode(let code): // or let inside param
    print("QR: \(code)")
}

// When you’re matching just one case of an enumeration — for example, to extract its associated value — you can use an if-case statement instead of writing a full switch statement. Here’s what it looks like:

if case .qrCode(let code) = productBarcode {
    print(code)
}

// Raw Values
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// Implicitly Assigned Raw Values
// When strings are used for raw values, the implicit value for each case is the text of that case’s name.
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

print(Planet.venus.rawValue)

// Initializing from a Raw Value
// If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called rawValue) and returns either an enumeration case or nil. You can use this initializer to try to create a new instance of the enumeration.
var p = Planet(rawValue: 7)  // uranus

// Recursive Enumerations
// A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. You indicate that an enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
// or
//indirect enum ArithmeticExpression {
//    case number(Int)
//    case addition(ArithmeticExpression, ArithmeticExpression)
//    case multiplication(ArithmeticExpression, ArithmeticExpression)
//}

// The code below shows the ArithmeticExpression recursive enumeration being created for (5 + 4) * 2:
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}


print(evaluate(product))
