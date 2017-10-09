//: Playground - noun: a place where people can play

import UIKit
enum testEnum {
    case first
    case second
}
let madridPopulation = 10

switch madridPopulation.hashValue {
    case 0:
        print("Nobody in Madrid")
    case (1..<1000):
        print("Less than a million in Madrid")
    default:
        print("greater than a million in Madrid")
}

func incrementOptional(optional: Int?) -> Int? {
    guard let x = optional else { return nil }
    return x + 1
}

print(incrementOptional(optional: nil))
print(incrementOptional(optional: 10))

//let x: Int? = 3
//let y: Int? = nil
//let z: Int? = x + y //error: value of optional type 'Int?' not unwrapped; did you mean to use '!' or '?'?
