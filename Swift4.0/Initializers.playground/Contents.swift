//: Playground - noun: a place where people can play

import UIKit

/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203
 Default Initializers
 
 Swift provides a default initializer for any structure or class that provides default values for all of its properties and does not provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.
 
 默认构造器
 swift为structure或者class提供了一个默认构造器，为它的所有属性提供默认值
 */
class ShoppingListItem {
    var name: String?  //  (The name property is an optional String property, and so it automatically receives a default value of nil, even though this value is not written in the code.)
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203
 Designated Initializers and Convenience Initializers
 
 Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
 Classes tend to have very few designated initializers, and it is quite common for a class to have only one. Designated initializers are “funnel” points through which initialization takes place, and through which the initialization process continues up the superclass chain.
 
 指定构造器和便利构造器
 
 指定构造器是一个类最主要的构造器。一个指定构造器将会初始化类中的全部属性，并且调用对应的父类构造器来继续父类初始化过程。
 类一般只有很少的指定构造器，对一个类来说，只拥有一个指定构造器非常的普遍。当初始化开始或者父类的的初始化进程正在进行，指定构造器像是在穿过漏斗的小口
 
 Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.
 You do not have to provide convenience initializers if your class does not require them.
 
 便利构造器是次要的、辅助性的构造器。你可以在定义便利构造器的时候，可以调用它的指定构造器将参数设为默认值。
 你也可以定义便利构造器来创建一个该类实例，用在一些特殊场景中或者传入某些值的类型。
 如果你的类不需要，你不必提供便利构造器
 */

class Food {
    var name: String
    // 指定构造器
    init(name: String) {
        self.name = name
    }
    
    // 便利构造器
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

/*
 To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:
 
 Rule 1
 A designated initializer must call a designated initializer from its immediate superclass.
 
 Rule 2
 A convenience initializer must call another initializer from the same class.
 
 Rule 3
 A convenience initializer must ultimately call a designated initializer.
 
 A simple way to remember this is:
     Designated initializers must always delegate up.
     Convenience initializers must always delegate across.
 
 为了简化指定构造器和便利构造器的关系，swift为构造器间的相互调用制定了下面三条规则：
 1. 一个类的指定构造器必须调用调用它父类的指定构造器
 2. 一个便利构造器必须调用另一个构造器
 3. 一个便利构造器最终必须调用一个指定构造器
 
 一个简单的记法：
 指定构造器必须向上代理. （调用父类的构造器）
 便利构造器必须横向代理. （调用同类中的其他构造器）
 */

/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203
 
 Two-Phase Initialization
 
 Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.
 
 两个阶段的初始化
 swift中类的初始化分为两个阶段的过程。在第一个阶段，类在声明它的属性的时候，将赋给他们一个初值。一旦每个属性的初始状态被确定，第二个阶段就开始了。在这个实例创建好并可以使用前，每个类都会给予一次机会来进一步客制化它的属性。
 */

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

/*
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203
 Required Initializers
 
 Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:
 You must also write the required modifier before every subclass implementation of a required initializer, to indicate that the initializer requirement applies to further subclasses in the chain. You do not write the override modifier when overriding a required designated initializer:
 
 必需(必要)构造器
 
 如果在构造器声明前添加了required修饰符，就要求该类的所有子类必须实现这个构造器。
 你也必须在子类的必需构造器前面跟着写上required修饰符，则这种“必需”属性将会继续传递给其子类。
 你在重写必要指定构造器的时候，你不用加上override修饰符。
 */
class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}

class SomeSubclass: SomeClass {
    required init() {
        // subclass implementation of the required initializer goes here
    }
}
