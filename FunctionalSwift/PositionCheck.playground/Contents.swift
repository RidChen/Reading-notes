//: Playground - noun: a place where people can play

import UIKit

typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func inRange(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
}

struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    func canEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <=  firingRange
    }
}
extension Ship {
    func canSafelyEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <=  firingRange && targetDistance > unsafeRange
    }
}
extension Ship {
    func canSafelyEngageShip1(target: Ship, friendly: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        let friendlyDx = friendly.position.x - target.position.x
        let friendlyDy = friendly.position.y - target.position.y
        let friendlyDistance = sqrt(friendlyDx * friendlyDx +
            friendlyDy * friendlyDy)
        return targetDistance <=  firingRange
            && targetDistance > unsafeRange && (friendlyDistance > unsafeRange)
    }
}

extension Position {
    func minus(p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }

    var length: Double {
        return sqrt(x * x + y * y)
    }
}

extension Ship {
    func canSafelyEngageShip2(target: Ship, friendly: Ship) -> Bool {
        let targetDistance = target.position.minus(p: position).length
        let friendlyDistance = friendly.position.minus(p: target.position).length
        return targetDistance <=  firingRange
            && targetDistance > unsafeRange && (friendlyDistance > unsafeRange)
    }
}

/* 一等函数的实现 */

typealias Region = (Position) -> Bool

// 以原点为圆心的圆 (circle)
func circle(_ radius: Distance) -> Region {
    return { point in point.length <= radius }
}

// 区域变换函数，按一定的偏移量移动一个区域
func shift(_ region: @escaping Region, _ offset: Position) -> Region {
    return {
        point in region(point.minus(p: offset))
    }
}

// 产生给定区域的补集
func invert(_ region: @escaping Region) -> Region {
    return { point in !region(point) }
}

// 两个区域的交集
func intersection(_ region1: @escaping Region, _ region2: @escaping Region) -> Region {
    return { point in region1(point) && region2(point) }
}
// 两个区域的并集
func union(_ region1: @escaping Region, _ region2: @escaping Region) -> Region {
    return { point in region1(point) || region2(point) }
}

func difference(_ region: @escaping Region, _ minus: @escaping Region) -> Region {
    return intersection(region, invert(minus))
}

extension Ship {
    func canSafelyEngageShip(target: Ship, friendly: Ship) -> Bool {
        let rangeRegion = difference(circle(firingRange), circle(unsafeRange))
        let firingRegion = shift(rangeRegion, position)
        let friendlyRegion = shift(circle(unsafeRange), friendly.position)
        let resultRegion = difference(firingRegion, friendlyRegion)
        return resultRegion(target.position)
    }
}

let unsafeRange = 50.0
let firingRange = 100.0

var mine = Ship(position: Position(x: 10, y: 10), firingRange: firingRange, unsafeRange: unsafeRange)
var target = Ship(position: Position(x: 60, y: 60), firingRange: firingRange, unsafeRange: unsafeRange)
var friend = Ship(position: Position(x: 100, y: 100), firingRange: firingRange, unsafeRange: unsafeRange)

print(mine.canSafelyEngageShip(target: target, friendly: friend))


struct Region2 {
    let lookup: (Position) -> Bool
}
extension Region2 {
    // 以原点为圆心的圆 (circle)
    func circle(_ radius: Distance) -> Region2 {
        return Region2(lookup: { point in point.length <= radius })
    }

    // 区域变换函数，按一定的偏移量移动一个区域
    func shift(_ offset: Position) -> Region2 {
        return Region2(lookup: {
            point in self.lookup(point.minus(p: offset))
        })
    }

    // 产生给定区域的补集
    func invert() -> Region2 {
        return Region2(lookup: { point in !self.lookup(point) })
    }

    // 两个区域的交集
    func intersection(_ region2: Region2) -> Region2 {
        return Region2(lookup: { point in self.lookup(point) && region2.lookup(point) })
    }
    // 两个区域的并集
    func union(_ region2: Region2) -> Region2 {
        return Region2(lookup: { point in self.lookup(point) || region2.lookup(point) })
    }

    func difference( _ minus: Region2) -> Region2 {
        return intersection(minus.invert())
    }
}
