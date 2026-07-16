//
//  StructuresClasses.swift
//  
//
//  Created by Kristine Doc on 7/16/26.
//


// definition
struct Structure {
    var lName: String
    var fName: String
    var age: Int
}

class Class {
    var fName: String
    var lName: String
    var age: Int
    
    // needs initializer
    init(fName: String, lName: String, age: Int) {
        self.fName = fName
        self.lName = lName
        self.age = age
    }
}

// Unlike structures, class instances don’t receive a default memberwise initializer. Initializers are described in more detail in Initialization.
var s = Structure(lName: "Doctor", fName: "Kristine", age: 34)
print(s)
var c = Class(fName: "Kristine", lName: "Doctor", age: 34)
print(c)

// Because classes are reference types, it’s possible for multiple constants and variables to refer to the same single instance of a class behind the scenes. (The same isn’t true for structures and enumerations, because they’re always copied when they’re assigned to a constant or variable, or passed to a function.)

// Identical to means that two constants or variables of class type refer to exactly the same class instance.
// Identical to (===)
// Not identical to (!==)
