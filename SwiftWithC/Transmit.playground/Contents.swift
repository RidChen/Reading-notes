import UIKit

class A: X {
    func printLn() {
        print("A")
    }
}

protocol X {
    func printLn()
}

class B: A {
    func printLn2() {
        print("B")
    }
}

let b = B()

b.printLn()
b.printLn2()