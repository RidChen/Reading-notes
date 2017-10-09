//: Playground - noun: a place where people can play

import UIKit

// 1
let count = 2
let stride = MemoryLayout<Int>.stride
let alignment = MemoryLayout<Int>.alignment
let byteCount = stride * count

// 2 raw pointer
do {
    print("Raw pointers")
    
    // 3
    let pointer = UnsafeMutableRawPointer.allocate(bytes: byteCount, alignedTo: alignment)
    print("\(pointer)")
    // 4
    defer {
        pointer.deallocate(bytes: byteCount, alignedTo: alignment)
        print("*cackles*")
    }
    print("Hello my pretties.")
    // 5
    pointer.storeBytes(of: 42, as: Int.self)
    pointer.advanced(by: stride).storeBytes(of: 6, as: Int.self)
    pointer.load(as: Int.self)
    pointer.advanced(by: stride).load(as: Int.self)
    (pointer+stride).load(as: Int.self)
    
    // 6
    let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
    print("\(bufferPointer)")
    for (index, byte) in bufferPointer.enumerated() {
        print("byte \(index): \(byte)")
    }
}


// type pointer
do {
    print("Typed pointers")
    
    let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
    pointer.initialize(to: 0, count: count)
    defer {
        pointer.deinitialize(count: count)
        pointer.deallocate(capacity: count)
    }
    
    pointer.pointee = 42
    pointer.advanced(by: 1).pointee = 6
    pointer.pointee
    pointer.advanced(by: 1).pointee

    let bufferPointer = UnsafeBufferPointer(start: pointer, count: count)
    for (index, value) in bufferPointer.enumerated() {
        print("value \(index): \(value)")
    }
}

struct SampleStruct {
    let number: UInt32
    let flag: Bool
}

do {
    print("Getting the bytes of an instance")
    
    var sampleStruct = SampleStruct(number: 25, flag: true)
    
    withUnsafeBytes(of: &sampleStruct) { bytes in
        for byte in bytes {
            print(byte)
        }
    }
}

do {
    print("Checksum the bytes of a struct")
    
    var sampleStruct = SampleStruct(number: 25, flag: true)
    
    let checksum = withUnsafeBytes(of: &sampleStruct) { (bytes: UnsafeRawBufferPointer) -> UInt32 in
        return ~bytes.reduce(UInt32(0)) { $0 + numericCast($1) }
    }
    
    print("checksum", checksum) // prints checksum 4294967269
}
