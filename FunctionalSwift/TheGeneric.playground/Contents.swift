//: Playground - noun: a place where people can play

import UIKit

// 顶层函数
func add(param1: Int, param2: Int) -> Int {
    return param1 + param2
}
print(add(param1: 1, param2: 2))

// 柯里化 (Currying)
func add2(param1: Int) -> (Int) -> Int {
    return { param2 in param1 + param2 }
}
print(add2(param1: 1)(2))

//泛型
func incrementArray(xs: [Int]) -> [Int] {
    var result = [Int]()
    
    for item in xs {
        result.append(item + 1)
    }
    return result
}
let arr = [1, 3, 5, 7 ,9]
print(incrementArray(xs: arr))

func incrementArrayGeneric<T>(xss: [[T]]) -> [T] {
    var result = [T]()
    
    for xs in xss {
        result.append(contentsOf: xs)
    }
    return result
}
print(incrementArrayGeneric(xss: [[1, 2, 3, 4], [11, 12, 13, 14], [21, 22, 23, 24]]))
print(incrementArrayGeneric(xss: [["A", "B", "C", "D"], [11, 12, 13, 14], ["E", "F", "G", "H"]]))

extension Array {
    func map<T>(transform: (Element) -> T) -> [T] {
        var result: [T] = []
        for x in self {
            result.append(transform(x)) }
        return result }
}

let origin = [1, 2, 3, 4]
let sqar = origin.map { (item) -> Int in
    return item * item
}
print("\(sqar)")
let increase = origin.map { (item) -> Int in
    return item + 1
}
print("\(increase)")

extension Array {
    func reduce<T>(initial: T, combine: (T, Element) -> T) -> T {
        var result = initial
        for x in self {
            result = combine(result, x)
        }
        return result
    }
}

let reduceIncrease = origin.reduce(initial: 0) { (param, distance) -> Int in
    return param + distance
}
print("\(reduceIncrease)")
let reduceMultiplication = origin.reduce(initial: 2, combine: *)
print("\(reduceMultiplication)")

extension Array {
    func mapUsingReduce<T>(transform: (Element) -> T) -> [T] {
        return reduce(initial: [], combine: { (result, x) -> [T] in
            return result + [transform(x)]
        })
    }
}

let sqarUsingReduce = origin.mapUsingReduce() { (item) -> Int in
    return item * item
}
print("\(sqarUsingReduce)")