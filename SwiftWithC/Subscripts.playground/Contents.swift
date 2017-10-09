//: Playground - noun: a place where people can play

import UIKit

/*
 Subscripts enable you to query instances of a type by writing one or more values in square brackets after the instance name. Their syntax is similar to both instance method syntax and computed property syntax. You write subscript definitions with the subscript keyword, and specify one or more input parameters and a return type, in the same way as instance methods. Unlike instance methods, subscripts can be read-write or read-only. This behavior is communicated by a getter and setter in the same way as for computed properties:
 */
struct TimesTable {
    var multiplier: Int
    subscript(index: Int) -> Int {
        get {
            return multiplier * index
        }
        
        set(newValue) {
            multiplier = newValue
        }
    }
}
var threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

threeTimesTable[6] = 5
print("six times three is \(threeTimesTable[6])")


// 尝试为String添加下标取值/设值的方法
extension String {
    subscript(index: Int) -> String {
        get {
            return self.substring(with: self.index(self.startIndex, offsetBy: index) ..< self.index(self.startIndex, offsetBy: index + 1))
        }
        set {
            if index < self.characters.count {
                if let char = newValue.characters.first {
                    self.characters.remove(at: self.index(self.startIndex, offsetBy: index))
                    self.characters.insert(char, at: self.index(self.startIndex, offsetBy: index))
                } else {
                    self.characters.remove(at: self.index(self.startIndex, offsetBy: index))
                }
            }
        }
    }
    subscript(range: CountableClosedRange<Int>) -> String {
        get {
            let lower = self.index(self.startIndex, offsetBy: range.lowerBound)
            let upper = self.index(self.startIndex, offsetBy: range.upperBound + 1)
            return self.substring(with: lower..<upper)
        }
        set {
            self.substring(to: self.index(self.startIndex, offsetBy: range.lowerBound))
            self.characters.replaceSubrange(self.index(self.startIndex, offsetBy: range.lowerBound) ... self.index(self.startIndex, offsetBy: range.upperBound), with: newValue.characters)
        }
    }
}

var helloWorld = "Hello World!"
print("\(helloWorld[0]) \(helloWorld[1]) \(helloWorld[2]) \(helloWorld[3]) \(helloWorld[4]) \(helloWorld[helloWorld.characters.count - 1])")
helloWorld[0] = "h"
helloWorld[6] = "w"
print(helloWorld)

print("\(helloWorld[0...4])")
helloWorld[0...4] = "Hi"
print(helloWorld)
