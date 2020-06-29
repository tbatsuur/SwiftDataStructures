//
//  StatisticalDistribution.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-07-27.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

enum ProbabilityDistribution {
    case Uniform
    case Binomial
    case Geometric
    case NegativeBinomial
    case Normal
}

struct StatisticalDistribution {
    fileprivate var arrayDiscreteDistribution = [Double]()
    
    
    init(type: ProbabilityDistribution, size: Int, probability: Double = 0.5) {
        self.arrayDiscreteDistribution = self.makeProbabilityDistribution(type: type, count: size, p: probability)
    }
    init(array: [Double]) {
        self.arrayDiscreteDistribution = array
    }
    
    
    //MARK: VARIABLES
    internal var randomIndex: Int {
        let sum = self.arrayDiscreteDistribution.reduce(0, +)
        let rnd = sum * Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
        var accum = 0.0
        for (i, p) in self.arrayDiscreteDistribution.enumerated() {
            accum += p
            if rnd < accum {
                return i
            }
        }
        return (self.arrayDiscreteDistribution.count - 1)
    }
    internal var arrayDistribution: [Double] {
        get {
            return self.arrayDiscreteDistribution
        }
    }
    
    
    
    
    
    //MARK: FUNCTIONS
    internal func makeProbabilityDistribution(type: ProbabilityDistribution, count: Int, p: Double = 0.1, r: Int = 2, mean: Double = 100, standard: Double = 10)-> [Double] {
        var array: [Double] = []
        if type == .Uniform {
            let p = 1.00 / Double(count)
            for _ in 0...(count - 1) {
                array.append(p)
            }
        }else if type == .Binomial {
            if count > 2 {
                for y in 0...(count) {
                    array.append(binomialProbability(y, n: count, p: p))
                }
            }
        }else if type == .Geometric {
            if count > 1 {
                for y in 1...(count) {
                    array.append(self.returnGeometricProbability(y, n: count, p: p))
                }
            }
        }else if type == .NegativeBinomial {
            if count > 1 {
                for y in r...(count) {
                    assert(count > r)
                    array.append(self.returnNegativeBinomialProbability(y, r: r, p: p))
                }
            }
        }else if type == .Normal {
            if count > 1 {
                let min = Int(mean - (3 * standard))
                let max = Int(mean + (3 * standard))
                for y in min...max {
                    array.append(self.returnNormalProbability(Double(y), standardDeviation: standard, mean: mean))
                }
            }
        }
        return array
    }
    

    
    
    //MARK: PROBABILITY FUNCTIONS
    /** n trials from 0...n,
     
     Note: p(y) = (n,y) * p^y * q^(n-y)
     */
    internal func returnBinomialProbability(_ y: Int, n: Int, p: Double)-> Double {
        let first = Double(binomialCoefficient(n, choose: y))
        let second = pow(p, Double(y))
        let third = pow((1-p), (Double(n-y)))
        return first * second * third
    }
    /** n trials from 1...n,
     
     Note: p(y) = p * q^(n-1), The geometric distribution handles the case where we are interested in the number of the trial on which the first success occurs
     */
    internal func returnGeometricProbability(_ y: Int, n: Int, p: Double)-> Double {
        let first = pow((1-p), Double(y-1))
        return first * p
    }
    /** The negative binomial distribution applies to the random variable Y equal to the number of the trial on which the rth success occurs (r = 2, 3, 4, etc.)
     */
    internal func returnNegativeBinomialProbability(_ y: Int, r: Int, p: Double)-> Double {
        let first = Double(binomialCoefficient((y - 1), choose: (r - 1)))
        let second = pow(p, Double(r))
        let third = pow((1 - p), Double(y - r))
        return first * second * third
    }
    internal func returnNormalProbability(_ y: Double, standardDeviation: Double, mean: Double)-> Double {
        let a = pow(standardDeviation, 2.0)
        let b = 2 * a
        let c = pow((y - mean), 2.0)
        let d = c / b
        let e = exp(-d)
        let denom = pow((2 * Double.pi), 1/2) * standardDeviation
        return e / denom
    }
}


extension StatisticalDistribution: CustomStringConvertible {
    var description: String {
        var texty = "||"
        for item in self.arrayDiscreteDistribution {
            texty += "\(item) ||"
        }
        return texty
    }
}
