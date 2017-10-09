//: Playground - noun: a place where people can play

import UIKit

/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94
 Global and nested functions, as introduced in Functions, are actually special cases of closures. Closures take one of three forms:
 
 Global functions are closures that have a name and do not capture any values.
 Nested functions are closures that have a name and can capture values from their enclosing function.
 Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
 全局和嵌套函数是一种特殊的闭包，闭包有三种形式
 全局函数是一种有包名，不捕获任何数值的闭包
 嵌套函数式一种有包名，能够从函数内部捕获数值的闭包
 闭包表达式是一种用轻量级语法描述的没有包名的闭包，能够从上下文中捕获数值
 
 Swift’s closure expressions have a clean, clear style, with optimizations,These optimizations include:
 
 Inferring parameter and return value types from context
 Implicit returns from single-expression closures
 Operator Methods
 Shorthand argument names
 Trailing closure syntax
 swift的闭包表达式给人一种干净、清晰的风格，包含了一些优化，包括：
 1. 推断参数，根据上下文来推断值类型
    reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
 2. 从一个简单闭包语句隐式返回
    reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
 3. 速写参数
    reversedNames = names.sorted(by: { $0 > $1 } )
 4. 操作法方法
    reversedNames = names.sorted(by: >)
 5. 尾随闭包语法
 */
