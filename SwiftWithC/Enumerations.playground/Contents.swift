//: Playground - noun: a place where people can play

import UIKit

/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145
 
 Recursive Enumerations
 
 A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. You indicate that an enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.
 
 You can also write indirect before the beginning of the enumeration, to enable indirection for all of the enumeration’s cases that need it:
 
 递归枚举
 递归枚举是特殊的枚举，它包含一个或多个特殊的cases，将另一个枚举对象作为其关联值。
 通过在添加在case前面添加indirect关键字来声明这个枚举case是递归的
 你也可以在enum的声明前面添加indirect，为所有的case添加间接枚举属性
 */
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}
// 此enum可以存储三种类型的算数表达式： 一个数字，两个表达式的和，两个表达式的积
// (5 + 4) * 2可以用下面的方法表达出来：
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

// 使用递归函数可以直接计算递归的数据结构
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
