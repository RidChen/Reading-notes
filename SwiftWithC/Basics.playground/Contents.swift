//: Playground - noun: a place where people can play

import UIKit

/****** 定义变量或常量 *********/
/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID322
 Because of type inference, Swift requires far fewer type declarations than languages such as C or Objective-C. Constants and variables are still explicitly typed, but much of the work of specifying their type is done for you.
 
 Because Swift is type safe, it performs type checks when compiling your code and flags any mismatched types as errors. This enables you to catch and fix errors as early as possible in the development process.

 因为swift有类型推断，swift可以让用户少写很多类型定义的语句，建议使用这种方式
 因为swift是类型安全的，编译器在编译阶段就会检查是否有类型错误，便于更早的发现问题
 */

/******变量名与关键字重名*******/
/* NOTE
 引用自: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309
 If you need to give a constant or variable the same name as a reserved Swift keyword, surround the keyword with backticks (`) when using it as a name. However, avoid using keywords as names unless you have absolutely no choice.
 
 若变量名与swift关键字重名，建议更换变量名，但如果无法避免，一定要使用，可以用``包裹变量 */
var `switch` = "0"
`switch` = "Hello"
print(`switch`)
/* 结构体内使用关键字名称作为变量名 */
struct Resolution {
    var `var` = 0
    var `do` = 0
    var `while` = "good"
}
var test = Resolution(`var`: 0, do: 1, while: "true")
test.while = "goods"
print(test)

/****** 数据分段与科学计数 *******/
/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309
 */
/* 为了避免大数据写错0的个数，可以使用下划线分隔，不会影响实际值 */
let oneMillion1 = 1_000_000 /* 老外习惯的分隔方法 */
let oneMillion2 = 100_0000  /* 国内习惯的分隔方法 */
print(oneMillion1 == oneMillion2)
/* 小数也可以分隔 */
let justOverOneMillion = 1_000_000.000_000_1


/****** 闭包的生命周期 *******/
/* 闭包的更多内容可以参见大神的文章:http://kb.cnblogs.com/page/110782/ */
/* 引用大神的话：*/
/* 闭包是一种设计原则，它通过分析上下文，来简化用户的调用，让用户在不知晓的情况下，达到他的目的 */
func makeIncrementer() -> (() -> Int) {
    /* count 是函数内的局部变量，生命周期只在函数内部 */
    var count = 0
    func addOne() -> Int {
        count += 1
        return count
    }
    /* 此处除了可以返回单个函数，还可以返回函数的数组 */
    /* 或者返回包含了函数、某些特定变量的字典 */
    /* 可以作为封装好的工具类使用，外部只能使用返回的特定变量与函数 */
    return addOne
}
var increment = makeIncrementer()
/* 只能调用increment函数，无法直接访问到内部的局部变量count */
/* 每次调用之后，count数都增加了1 */
increment()
increment()
increment()
increment()


/******可选绑定*****/
/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309
 You use optional binding to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable. Optional binding can be used with if and while statements to check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action.
 */
/*
 可选绑定可以帮助你找出一个可选变量是否包含一个合法的值
 如果包含的话，将其存在一个临时的变量或者常量中
 这种绑定可以用在if或者while语句中
 */
let possibleNumber = "12333.1231"
if let actualNumber = Double(possibleNumber) {
    print("\"\(possibleNumber)\" has an Double value of \(actualNumber)")
} else {
    print("\"\(possibleNumber)\" could not be converted to an integer")
}

/* 如果要获得或者比较iOS版本，直接强转为Float或Double在swift上面是很有可能会失败的 */
/* 比如我现在的当前版本是10.3.1, OC上面可以强转为10.3，但swift将会转失败，返回nil，如果再强制解包就会崩溃 */
let systemVersion = UIDevice.current.systemVersion
if let iosVersion = Float(systemVersion) {
    print("当前的系统版本是：\(iosVersion)")
} else {
    print("不能转换为有效的Float，因为系统版本号是：\(systemVersion)")
}

/********隐式强制解包*******/
/* 
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309
 Sometimes it is clear from a program’s structure that an optional will always have a value, after that value is first set. In these cases, it is useful to remove the need to check and unwrap the optional’s value every time it is accessed, because it can be safely assumed to have a value all of the time.

 如果你非常清楚一个变量在第一次赋值之后，会一直持有合法的值
 可以使用隐式强制解包，这样就不用在每一次使用的时候都要做强制解包
 */
var assumedString: String! = nil
assumedString = "An implicitly unwrapped optional string"
print(assumedString)
/*
 NOTE
 
 If an implicitly unwrapped optional is nil and you try to access its wrapped value, you’ll trigger a runtime error. The result is exactly the same as if you place an exclamation mark after a normal optional that does not contain a value.

 如果一个隐式强制解包的变量为空，当你试图访问他的解包值的时候，就会崩溃，这个效果(崩溃)和你显示的强制解包这个值一样 */


/**********异常处理************/
/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html#//apple_ref/doc/uid/TP40014097-CH42-ID508
 Using try? lets you write concise error handling code when you want to handle all errors in the same way. For example, the following code uses several approaches to fetch data, or returns nil if all of the approaches fail.
 */

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

func fetchDataFromDisk(isThrows: Bool) throws -> Data? {
    if isThrows {
        throw VendingMachineError.invalidSelection
    }
    return Data()
}

func fetchDataFromServer(isThrows: Bool) throws -> Data? {
    if isThrows {
        let errorCodeOrValue = -1
        throw VendingMachineError.insufficientFunds(coinsNeeded: errorCodeOrValue)
    }
    return Data()
}

func throwAlways() throws {
    throw VendingMachineError.invalidSelection
}

func notThrowAlways() throws {
}


func fetchData() -> Data? {
    do {
        try throwAlways()
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.outOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    } catch {
        print("unhandled exception.")
    }

    if let data = try? fetchDataFromDisk(isThrows: false) { return data }
    if let data = try? fetchDataFromServer(isThrows: false) { return data }
    return nil
}

/*
 Sometimes you know a throwing function or method won’t, in fact, throw an error at runtime. On those occasions, you can write try! before the expression to disable error propagation and wrap the call in a runtime assertion that no error will be thrown. If an error actually is thrown, you’ll get a runtime error.
 如果你知道一个函数在实际使用中，一定不会抛出异常，你可以在表达式前使用try!
 但如果异常发生了，就会崩溃(runtime error)
 */

//let photo = try! throwAlways() // will crash
let _ = try! notThrowAlways() // success


/********* defer的使用 ********/
/*
 You use a defer statement to execute a set of statements just before code execution leaves the current block of code. This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves the current block of code—whether it leaves because an error was thrown or because of a statement such as return or break. For example, you can use a defer statement to ensure that file descriptors are closed and manually allocated memory is freed.
 使用defer包裹的语句，将会在函数返回前执行，包括由于return break throw error等终止语句造成的返回
 */
var fileHandle = 0
func processFile(filename: String) -> Bool {
    /* 指针、对象的分配与释放(CoreGraphics的很多需要手动释放的接口)，文件的打开与关闭，程序、函数异常退出时清除app状态等场景比较适用，避免后面忘记写释放造成内存泄漏 */
    let file = malloc(100)
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);

    // 无论从哪里退出，将会执行此处的语句
    defer {
        free(file)
        fileHandle = 0
//        CGImageRelease(scaledImage);
    }
    
    // 某些状态或参数发生改变
    fileHandle = 10
    
    if filename.isEmpty {
        // 异常退出
        return false
    } else if filename == "invalid path" {
        // 异常退出
        return false
    } else {
        // 正常执行后退出
        return true
    }
}