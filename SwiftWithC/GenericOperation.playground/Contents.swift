//: Playground - noun: a place where people can play

import UIKit

struct City {
    let name: String
    let population: Int
}


let paris = City(name: "Paris", population: 2241)
let madrid = City(name: "Madrid", population: 3165)
let amsterdam = City(name: "Amsterdam", population: 827)
let berlin = City(name: "Berlin", population: 3562)

let cities = [paris, madrid, amsterdam, berlin]

extension City {
    func cityByScalingPopulation() -> City {
        return City(name: name, population: population * 1000) }
}

print(cities.filter{ $0.population > 1000 }.map { $0.cityByScalingPopulation() }.reduce("City: Population") { result, c in
    return result + "\n" + "\(c.name): \(c.population)"
})


func noOp<T>(x: T) -> T {
    return x
}

func noOpAny(x: Any) -> Any {
    return x
}

let testParam = 2
print(noOp(x: testParam))
print(noOpAny(x: testParam))
