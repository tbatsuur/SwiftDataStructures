//
//  RingBuffer.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-07-30.
//  Copyright © 2018 . All rights reserved.
//

import Foundation

struct RingBuffer<Element> {
    fileprivate var array: [Element?]
    fileprivate var readIndex: Int = 0
    fileprivate var writeIndex: Int = 0
    
    public init(count: Int) {
        self.array = [Element?](repeating: nil, count: count)
    }
    
    
    //MARK: MUTATING FUNCTIONS
    mutating func enqueue(_ element: Element)-> Bool {
        if !self.isFull {
            self.array[writeIndex % self.array.count] = element
            self.writeIndex += 1
            return true
        }else {
            return false
        }
    }
    mutating func dequeue()-> Element? {
        if !self.isEmpty {
            let element = self.array[self.readIndex % self.array.count]
            readIndex += 1
            return element
        }else {
            return nil
        }
    }
    
    
    
    
    //MARK: SIMPLE FUNCTIONS
    fileprivate var availableSpaceForWriting: Int {
        return self.array.count - self.availableSpaceForReading
    }
    fileprivate var availableSpaceForReading: Int {
        return self.writeIndex - self.readIndex
    }
    public var isFull: Bool {
        return self.availableSpaceForWriting == 0
    }
    public var isEmpty: Bool {
        return self.availableSpaceForReading == 0
    }
}
