//: Playground - noun: a place where people can play

import UIKit

/******泛型方法/函数******/
/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179
 Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.
 泛型代码可以让你写出灵活、可复用的函数，它可以传入任何类型的参数来满足你的要求
 
 In most cases, type parameters have descriptive names, such as Key and Value in Dictionary<Key, Value> and Element in Array<Element>, which tells the reader about the relationship between the type parameter and the generic type or function it’s used in. However, when there isn’t a meaningful relationship between them, it’s traditional to name them using single letters such as T, U, and V, such as T in the swapTwoValues(_:_:) function above.
 大多数情况下，参数类型是一个描述性的名字，比如字典Dictionary<Key, Value>中的Key，Value，数组Array<Element>中的Element，可以直观的告诉使用者类型参数和泛型类型或者函数之间的关系。但是，如果当它们之间没有什么有意义的关系时，传统的做法是使用一个单一字母来作为泛型类型，例如：T，U，V...
 
 NOTE
 
 Always give type parameters upper camel case names (such as T and MyTypeParameter) to indicate that they are a placeholder for a type, not a value.
 请使用首字母大写的驼峰字作为类型参数，表明这是一个类型的占位符，不是一个值
 
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID173
 You write an in-out parameter by placing the inout keyword right before a parameter’s type. An in-out parameter has a value that is passed in to the function, is modified by the function, and is passed back out of the function to replace the original value.
 在形参前加入inout关键字，可以指定该参数是输入输出类型，将值传递变成引用传递
 */

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
print("\(someInt), \(anotherInt)")
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print("\(someString), \(anotherString)")
// someString is now "world", and anotherString is now "hello"

/***********关联类型*************/
/*
 When defining a protocol, it is sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that is used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.
 在定义协议时，有时将一个或多个关联类型声明为协议定义的一部分是有用的。一个相关联的类型给出了一个占位符名称到被用作协议的一部分的类型。在采用协议之前，不会指定用于该关联类型的实际类型。关联类型用 associatedtype 关键字指定。
 */
protocol Container {
    associatedtype Item // 关联类型，在实际使用中，将会自动推断Item类型是什么类型
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

// 约束
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        
        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // Check each pair of items to see if they are equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // All items match, so return true.
        return true
}
let stack1 = Stack(items: [1, 2, 3, 4, 5])
let stack2 = Stack(items: ["1", "2", "3", "4", "5"])
var stack3 = Stack<Int>()
stack3.push(1)
stack3.push(2)
stack3.push(3)
stack3.push(4)
stack3.push(5)
//print(allItemsMatch(stack1, stack2)) // 报错 stack1.Item != stack2.Item
print(allItemsMatch(stack1, stack3))

/********使用带有where语句的泛型进行扩展*********/
/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179
 You can also use a generic where clause as part of an extension. The example below extends the generic Stack structure from the previous examples to add an isTop(_:) method.
 带有where语句的泛型也可以作为扩展的一部分，下面的例子往前面的Stack中新增了一个isTop方法
 */
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

let testRef = 5
if stack3.isTop(testRef) {
    print("Top element is \(testRef)")
} else {
    print("Top element is something else.")
}