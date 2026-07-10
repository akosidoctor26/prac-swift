//
//  Functions.swift
//  
//
//  Created by Kristine Doc on 7/9/26.
//



// Tuple types
func minMax(array: [Int]) -> (Int, Int) {
    var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
}
//print(minMax(array: [3,2,6,3,1,8,2,9]))


// Implicit Return
func greeting(for person: String) -> String {
    "Hello \(person)"
}

//print(greeting(for: "Kristine"))

//Function Argument Labels and Parameter Names
func argParam(argumentLabel parameterName: Int) {
    // caller will see argumentLabel but inside the func
    // parameterName variable will be used
}


// Omitting Argument Labels
// If you don’t want an argument label for a parameter, write an underscore (_) instead of an explicit argument label for that parameter.

func omitArg(_ firstParameterName: Int, _ secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
    print(firstParameterName, secondParameterName)
}
omitArg(1, 2)

// Default Parameter Values
func defaultParam(name: String = "there") {
    print("Hello, \(name)")
}
defaultParam()


// Variadic Parameters
// Write variadic parameters by inserting three period characters (...) after the parameter’s type name.
func arithmeticMean (_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
// returns 10.0, which is the arithmetic mean of these three numbers

// In-Out Parameters
// Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.
//You write an in-out parameter by placing the inout keyword right before a parameter’s type.

// You can only pass a variable as the argument for an in-out parameter. You can’t pass a constant or a literal value as the argument, because constants and literals can’t be modified. You place an ampersand (&) directly before a variable’s name when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.

func inOutParams(name: inout String) {
    name += " (Last Name)"
    print(name)
}
var myName = "Kristine"
inOutParams(name: &myName)
print(myName)

// Function Types

func addTwoInts (_ a: Int, _ b:Int) -> Int {
     a + b
}
var mathFunc: (Int, Int) -> Int = addTwoInts

print(mathFunc(1,2))

// Function Types as Parameter Types
func printMathResult(_ fn: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print(fn(a,b))
}
printMathResult(addTwoInts, 4,5)

// Function Types as Return Types
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

print(chooseStepFunction(backward: true)(2))

// Nested Fucntions
// All of the functions you have encountered so far in this chapter have been examples of global functions, which are defined at a global scope. You can also define functions inside the bodies of other functions, known as nested functions.

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!
