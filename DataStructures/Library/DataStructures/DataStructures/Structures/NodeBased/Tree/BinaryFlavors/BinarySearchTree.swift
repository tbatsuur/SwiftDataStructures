//
//  BinarySearchTree.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-10-29.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation
//import Accelerate

public class BinarySearchTree<T: Comparable>: Comparable {
    //COMPARABLE
    public static func < (lhs: BinarySearchTree<T>, rhs: BinarySearchTree<T>) -> Bool {
        return lhs.value < rhs.value
    }
    public static func == (lhs: BinarySearchTree<T>, rhs: BinarySearchTree<T>) -> Bool {
        if lhs.isRoot && rhs.isRoot {
            return true
        }else if lhs.isLeaf && rhs.isLeaf {
            return lhs.value == rhs.value
        }else {
            return lhs.value == rhs.value
        }
    }
    
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    
    public init(value: T) {
        self.value = value
    }
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
    
    //Root
    public var isRoot: Bool {
        return self.parent == nil
    }
    //Leaf
    public var isLeaf: Bool {
        return self.left == nil && self.right == nil
    }
    
    //Left
    public var isLeft: Bool? {
        if let parentLeft = self.parent?.left {
            return parentLeft == self
        }else {
            return nil
        }
    }
    public var hasLeftChild: Bool {
        return self.left != nil
    }
    
    
    //Right
    public var isRight: Bool? {
        if let parentRight = self.parent?.right {
            return parentRight == self
        }else {
            return nil
        }
    }
    public var hasRightChild: Bool {
        return self.right != nil
    }
    
    //Children
    public var hasAnyChildren: Bool {
        return self.hasLeftChild || self.hasRightChild
    }
    public var hasBothChildren: Bool {
        return self.hasLeftChild && self.hasRightChild
    }
    
    //Count: number of nodes
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    public var averageCount: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    public var height: Int? {
        //nodes = elements / 2^ (h+1)
        //2^ (h+1) = elements / node
        //(h+1)log(2) = log(elements/nodes)
        //h= log(elements/nodes) / log(2) - 1
        
        let height = (log(Double(self.averageCount / self.count)) / log(2)) - 1
        return Int(height)
    }
    
    //Insert
    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            }else {
                self.left = BinarySearchTree(value: value)
                self.left?.parent = self
            }
        }else {
            if let right = self.right {
                right.insert(value: value)
            }else {
                self.right = BinarySearchTree(value: value)
                self.right?.parent = self
            }
        }
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
    public var asString:String { return treeString(self){("\($0.value)",$0.left,$0.right)}  }
}

//MARK: DOUBLE AND INT HELPERS FOR TREES
extension Int {
    static func getArray(from: Int, to: Int)-> [Int] {
        var array = [Int]()
        var temp = from
        while temp < to {
            array.append(temp)
            temp += 1
        }
        return array
    }
}

extension Double {
    public static func ^(lhs: Double, rhs: Double)-> Double {
        return pow(lhs, rhs)
    }
    var nodesInLevel: Int {
        return Int(2.0^self)
    }
    var sumOfEverythingBelow: Int? {
        if self >= 2.0 {
            var runningSum: Double = 0.0
            for level in self.everythingBelowIt {
                //print("Level:\(level) => \(Double(level).nodesInLevel)")
                runningSum = runningSum + Double(Double(level).nodesInLevel)
            }
            return Int(runningSum)
        }else {
            return nil
        }
    }
    var minimumForLevel: Int? {
        if self >= 2.0 {
            if let sum = self.sumOfEverythingBelow {
                return sum - self.nodesInLevel
            }else {
                return nil
            }
        }else {
            return nil
        }
    }
    var everythingBelowIt: [Int] {
        var array: [Int] = []
        let integerRepresentation: Int = Int(self)
        var temp = integerRepresentation
        while temp >= 0 {
            array.append(temp)
            temp -= 1
        }
        return array
    }
}


