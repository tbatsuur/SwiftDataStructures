//
//  RootishArrayStack.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-05-15.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation
import Darwin

public struct RootishArrayStack<Element> {
    fileprivate var blocks = [Array<Element?>]()
    fileprivate var internalCount = 0
    
    public init() {}
    
    //MARK: SIMPLE FUNCTIONS
    var count: Int {
        return self.internalCount
    }
    var capacity: Int {
        return self.blocks.count * (self.blocks.count + 1) / 2
    }
    
    
    
    //MARK: GET & SET
    fileprivate func block(fromIndex: Int) -> Int {
        let block = Int(ceil((-3.0 + sqrt(9.0 + 8.0 * Double(fromIndex))) / 2))
        return block
    }
    fileprivate func innerBlockIndex(fromIndex index: Int, fromBlock block: Int) -> Int {
        return index - block * (block + 1) / 2
    }
    
    public subscript(index: Int) -> Element {
        get {
            let block = self.block(fromIndex: index)
            let innerBlockIndex = self.innerBlockIndex(fromIndex: index, fromBlock: block)
            return blocks[block][innerBlockIndex]!
        }
        set(newValue) {
            let block = self.block(fromIndex: index)
            let innerBlockIndex = self.innerBlockIndex(fromIndex: index, fromBlock: block)
            blocks[block][innerBlockIndex] = newValue
        }
    }
    
    
    //MARK: GROW & SHRINK
    fileprivate mutating func growIfNeeded() {
        if capacity - blocks.count < count + 1 {
            let newArray = [Element?](repeating: nil, count: blocks.count + 1)
            blocks.append(newArray)
        }
    }
    fileprivate mutating func shrinkIfNeeded() {
        if capacity + blocks.count >= count {
            while blocks.count > 0 && (blocks.count - 2) * (blocks.count - 1) / 2 >    count {
                blocks.remove(at: blocks.count - 1)
            }
        }
    }
    
    
    //MARK: SWIFT ARRAY BEHAVIOUR
    public mutating func insert(element: Element, atIndex index: Int) {
        growIfNeeded()
        internalCount += 1
        var i = count - 1
        while i > index {
            self[i] = self[i - 1]
            i -= 1
        }
        self[index] = element
    }
    public mutating func append(element: Element) {
        insert(element: element, atIndex: count)
    }
    public mutating func remove(atIndex index: Int) -> Element {
        let element = self[index]
        for i in index..<count - 1 {
            self[i] = self[i + 1]
        }
        internalCount -= 1
        makeNil(atIndex: count)
        shrinkIfNeeded()
        return element
    }
    
    fileprivate mutating func makeNil(atIndex index: Int) {
        let block = self.block(fromIndex: index)
        let innerBlockIndex = self.innerBlockIndex(fromIndex: index, fromBlock: block)
        blocks[block][innerBlockIndex] = nil
    }
}
