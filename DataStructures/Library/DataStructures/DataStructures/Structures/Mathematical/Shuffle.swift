//
//  Shuffle.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-05-15.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Darwin

extension Array {
    public mutating func naiveShuffle() {
        var temp = [Element]()
        while !isEmpty {
            let i = arc4random_uniform(UInt32(self.count))
            let obj = remove(at: Int(i))
            temp.append(obj)
        }
        self = temp
    }
    public mutating func shuffle() {
        for i in stride(from: count - 1, through: 1, by: -1) {
            let j: Int = Int(arc4random_uniform(UInt32(self.count)))
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
    public func shuffledArray(_ n: Int) -> [Int] {
        var a = [Int](repeating: 0, count: n)
        for i in 0..<n {
            let j: Int = Int(arc4random_uniform(UInt32(self.count)))
            if i != j {
                a[i] = a[j]
            }
            a[j] = i
        }
        return a
    }
}
