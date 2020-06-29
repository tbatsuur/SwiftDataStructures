//
//  BitSet.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-05-13.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

public struct BitSet {
    //MARK: VARIABLES
    private(set) public var size: Int
    
    private let N = 64
    public typealias Word = UInt64
    fileprivate(set) public var words: [Word]
    
    public var cardinality: Int {
        var count = 0
        for var x in words {
            while x != 0 {
                let y = x & ~(x - 1)  // find lowest 1-bit
                x = x ^ y             // and erase it
                count += 1
            }
        }
        return count
    }
    
    //MARK: INITIALIZER
    public init(size: Int) {
        precondition(size > 0)
        self.size = size
        
        let n = (size + (N-1)) / N
        words = [Word](repeating: 0, count: n)
    }
    
    //MARK: METHODS
    private func indexOf(_ i: Int)-> (Int, Word) {
        precondition(i >= 0)
        precondition(i < size)
        let o = i / N
        let m = Word(i - o*N)
        return (o, 1 << m)
    }
    //BITWISE MUTATIONS
    public mutating func set(_ i: Int) {
        let (j, m) = indexOf(i)
        words[j] |= m
    }
    public mutating func clear(_ i: Int) {
        let (j, m) = indexOf(i)
        words[j] = ~m
    }
    public func isSet(_ i: Int)-> Bool {
        let (j, m) = indexOf(i)
        return (words[j] & m) != 0
    }
    public subscript(i: Int)-> Bool {
        get {
            return isSet(i)
        }
        set {
            if newValue {
                set(i)
            }else {
                clear(i)
            }
        }
    }
    
    public mutating func flip(_ i: Int)-> Bool {//New value of the bit
        let (j, m) = indexOf(i)
        words[j] ^= m
        return (words[j] & m) != 0
    }
    public mutating func clearAll() {
        for i in 0..<words.count {
            words[i] = 0
        }
    }
    public mutating func setAll() {
        for item in 0...(self.size - 1) {
            self[item] = true
        }
    }
    
}


extension BitSet: CustomStringConvertible {
    public var description: String {
        var toReturn = ""
        for item in 0...(self.size - 1) {
            if (item % 64 == 0) {
                toReturn += "\n"
            }
            if self[item] == true {
                toReturn += "1"
            }else {
                toReturn += "0"
            }
        }
        return toReturn
    }
}
