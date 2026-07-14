//
//  Closures.swift
//  
//
//  Created by Kristine Doc on 7/10/26.
//

// Syntax
//{ (<#parameters#>) -> <#return type#> in
//   <#statements#>
//}


// Sorted()
var nums = [5,43,3,1,2,3,4,6,7,3,45,42,8,9,3]

func asc (_ a: Int, _ b: Int) -> Bool {
    return b > a
}

var sortedByAsc = nums.sorted(by: asc)
print (sortedByAsc)

// The start of the closure’s body is introduced by the in keyword. This keyword indicates that the definition of the closure’s parameters and return type has finished, and the body of the closure is about to begin.
var sortedByDesc = nums.sorted(by: {(_ a:Int, _ b:Int) -> Bool in
    return a > b
})
print(sortedByDesc)

// Inferring Type From Context
// Because it's infered, it can be written as this
var sortedByDesc2 = nums.sorted(by: {a,b in a > b})
print(sortedByDesc2)

// Shorthand Argument Names
// Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
var sortedByAsc2 = nums.sorted(by: {$0 < $1})
print(sortedByAsc2)

// Operator Methods
// There’s actually an even shorter way to write the closure expression above. Swift’s String type defines its string-specific implementation of the greater-than operator (>) as a method that has two parameters of type String, and returns a value of type Bool. This exactly matches the method type needed by the sorted(by:) method. Therefore, you can simply pass in the greater-than operator, and Swift will infer that you want to use its string-specific implementation:

print(nums.sorted(by: >))


// Trailing Closures
// If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead.

// A function call can include multiple trailing closures; however, the first few examples below use a single trailing closure.


func someFuncThatTakesClosure(closure: () -> Void){
    closure()
}

someFuncThatTakesClosure(closure: {
    print("I am the closure using arg")
})

someFuncThatTakesClosure() {
    print("I am the closure using trailing closure")
}

var nums = [5,43,3,1,2,3,4,6,7,3,45,42,8,9,3]
print(nums.sorted() { $0 > $1 })

//If a closure expression is provided as the function’s or method’s only argument and you provide that expression as a trailing closure, you don’t need to write a pair of parentheses () after the function or method’s name when you call the function:
print(nums.sorted { $0 < $1 })


print(nums.map { num in
    return num * 2
})

// Func accepts multiple closures
// If a function takes multiple closures, you omit the argument label for the first trailing closure and you label the remaining trailing closures. For example, the function below loads a picture for a photo gallery:

func multipleClosure(success: Bool, onSuccess: () -> Void, onError: () -> Void) {
    if success {
        onSuccess()
    }
    else {
        onError()
    }
}

multipleClosure(success: true) {
    print("Success!")
} onError: {
    print("Error!")
}


// Capturing Values
// The incrementer() function doesn’t have any parameters, and yet it refers to runningTotal and amount from within its function body. It does this by capturing a reference to runningTotal and amount from the surrounding function and using them within its own function body. Capturing by reference ensures that runningTotal and amount don’t disappear when the call to makeIncrementer ends, and also ensures that runningTotal is available the next time the incrementer function is called.
func makeIncrementer(_ amt: Int) -> () -> Int {
    var total = 0
    func incrementer() -> Int {
        total = total + amt
        return total
    }
    
    return incrementer
}

var incrementer = makeIncrementer(3)
print(incrementer())
print(incrementer())
print(incrementer())


//Closures Are Reference Types
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// returns a value of 50


incrementByTen()
// returns a value of 60


// Escaping closure
// A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.

// One way that a closure can escape is by being stored in a variable that’s defined outside the function. As an example, many functions that start an asynchronous operation take a closure argument as a completion handler. The function returns after it starts the operation, but the closure isn’t called until the operation is completed — the closure needs to escape, to be called later. For example:

// Ginagamit to sa async funcs
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}


// Autoclosures
// An autoclosure is a closure that’s automatically created to wrap an expression that’s being passed as an argument to a function. It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it. This syntactic convenience lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.

// An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure. Delaying evaluation is useful for code that has side effects or is computationally expensive, because it lets you control when that code is evaluated. The code below shows how a closure delays evaluation.

var customers = ["Kris", "Tine", "Doc"]
print(customers)

var autoClosure = {customers.remove(at: 0)}
autoClosure()
print(customers)

// You get the same behavior of delayed evaluation when you pass a closure as an argument to a function.
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customers.remove(at: 0) } )
// Prints "Now serving Alex!"
