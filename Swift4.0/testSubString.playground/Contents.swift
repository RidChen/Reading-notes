//: Playground - noun: a place where people can play

import UIKit

let greeting = "Hello, world!"
let index = greeting.index(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]

let testString =
"""
    God is in his heaven,
    all's right with the world!
"""

print(testString)

