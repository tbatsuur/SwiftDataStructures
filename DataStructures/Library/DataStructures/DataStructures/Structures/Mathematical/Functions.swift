//
//  Functions.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-05-15.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation


//MARK: COMBINATORICS
func factorial(_ n: Int) -> Int {
    var n = n
    var result = 1
    while n > 1 {
        result *= n
        n -= 1
    }
    return result
}
func permutations(_ n: Int, _ k: Int) -> Int {
    var n = n
    var answer = n
    for _ in 1..<k {
        n -= 1
        answer *= n
    }
    return answer
}
fileprivate func permuteWirth<T>(_ a: [T], _ n: Int) {
    if n == 0 {
        print(a)   // display the current permutation
    } else {
        var a = a
        permuteWirth(a, n - 1)
        for i in 0..<n {
            a.swapAt(i, n)
            permuteWirth(a, n - 1)
            a.swapAt(i, n)
        }
    }
}
func permuteThese<T>(array: [T]) {
    permuteWirth(array, (array.count - 1))
}
func combinations(_ n: Int, choose k: Int) -> Int {
    return permutations(n, k) / factorial(k)
}
func quickBinomialCoefficient(_ n: Int, choose k: Int) -> Int {
    var result = 1
    for i in 0..<k {
        result *= (n - i)
        result /= (i + 1)
    }
    return result
}
func binomialCoefficient(_ n: Int, choose k: Int) -> Int {
    var bc = Array(repeating: Array(repeating: 0, count: n + 1), count: n + 1)
    
    for i in 0...n {
        bc[i][0] = 1
        bc[i][i] = 1
    }
    
    if n > 0 {
        for i in 1...n {
            for j in 1..<i {
                bc[i][j] = bc[i - 1][j - 1] + bc[i - 1][j]
            }
        }
    }
    
    return bc[n][k]
}
/**
 n Pick x, permutations function
 - Parameter x: Integer
 - Parameter n: Integer
 
 - Returns: Integer
 */
func permutation(_ n: Int, pick x: Int)-> Int {
    let numerator = n.factorial
    let denominator = (n-x).factorial
    return numerator / denominator
}
/**
 n Choose x, combinations function
 - Parameter x: Integer
 - Parameter n: Integer
 
 - Returns: Integer
 */
func combination(_ n: Int, choose x: Int)-> Int {
    let numerator = permutation(5, pick: 2)
    let denominator = x.factorial
    return numerator / denominator
}








//MARK: GEOMETRY
func haversineDinstance(la1: Double, lo1: Double, la2: Double, lo2: Double, radius: Double = 6367444.7) -> Double {
    
    let haversin = { (angle: Double) -> Double in
        return (1 - cos(angle))/2
    }
    
    let ahaversin = { (angle: Double) -> Double in
        return 2*asin(sqrt(angle))
    }
    
    // Converts from degrees to radians
    let dToR = { (angle: Double) -> Double in
        return (angle / 360) * 2 * Double.pi
    }
    
    let lat1 = dToR(la1)
    let lon1 = dToR(lo1)
    let lat2 = dToR(la2)
    let lon2 = dToR(lo2)
    
    return radius * ahaversin(haversin(lat2 - lat1) + cos(lat1) * cos(lat2) * haversin(lon2 - lon1))
}
func distance(pointA: CartesianPoint, pointB: CartesianPoint)-> Double {
    var distance = 0.0
    let a = pointA.x - pointB.x
    let b = pointA.y - pointB.y
    let c = pow(a, 2.0)
    let d = pow(b, 2.0)
    let e = c + d
    distance = pow(e, 1/2)
    return distance
}









//MARK: PROBABILITY
func returnRandomIndex(probabilites: [Double])-> Int {
    let sum = probabilites.reduce(0, +)
    let rnd = sum * Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
    var accum = 0.0
    for (i, p) in probabilites.enumerated() {
        accum += p
        if rnd < accum {
            return i
        }
    }
    return (probabilites.count - 1)
}
func makeProbabilityDistribution(type: ProbabilityDistribution, count: Int, p: Double = 0.1)-> [Double] {
    var array: [Double] = []
    if type == .Uniform {
        let p = 1.00 / Double(count)
        for _ in 0...(count - 1) {
            array.append(p)
        }
    }else if type == .Binomial {
        //n trials from 0...n
        //p(y) = (n,y) * p^y * q^(n-y)
        if count > 2 {
            for y in 0...(count) {
                array.append(binomialProbability(y, n: count, p: p))
            }
        }
    }
//    printWithAttention(array)
    return array
}
func binomialProbability(_ y: Int, n: Int, p: Double)-> Double {
    let first = Double(binomialCoefficient(n, choose: y))
    let second = pow(p, Double(y))
    let third = pow((1-p), (Double(n-y)))
    return first * second * third
}
