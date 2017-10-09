//: Playground - noun: a place where people can play

import UIKit

/*
 Resolving Strong Reference Cycles for Closures
 
 Each item in a capture list is a pairing of the weak or unowned keyword with a reference to a class instance (such as self) or a variable initialized with some value (such as delegate = self.delegate!). These pairings are written within a pair of square braces, separated by commas.
 
 捕获列表中的每个项目可以使用weak或者unowned关键字声明，例如sefl或者某些初始化的变量(delegate = self.delegate)
 解决闭包强引用循环
 */
protocol testProtocol: class {

}
class test: testProtocol {
    
    var delegate: testProtocol?
    
    lazy var someClosure: (Int, String) -> String = {
        [weak self, weak params = self.delegate!] (index: Int, stringToProcess: String) -> String in
        
        // closure body goes here
        return ""
    }
}

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil
// 造成循环引用，asHTML闭包持有了paragraph的self指针，paragraph也持有了闭包asHTML
// 可以在lazy var asHTML的default value内加unowned或weak来解决.
//lazy var asHTML: () -> String = {[unowned self] in
//    if let text = self.text {
//        return "<\(self.name)>\(text)</\(self.name)>"
//    } else {
//        return "<\(self.name) />"
//    }
//}
/*
 In this case, the capture list is [unowned self], which means “capture self as an unowned reference rather than a strong reference”.
 在这个例子中，捕获列表是unowned self，它表示将self作为一个无主的引用来捕获
 */
// unowned 关键字与weak两者的区别在哪里？
// 倘若你使用 weak,属性可以是可选类型，即允许有 nil 值的情况。
// 另一方面，倘若你使用 unowned，它不允许设为可选类型。因为一个 unowned 属性不能为可选类型，那么它必须在 init 方法中初始化值：
