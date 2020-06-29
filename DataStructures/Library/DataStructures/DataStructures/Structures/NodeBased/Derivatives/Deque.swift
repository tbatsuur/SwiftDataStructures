//
//  Deque.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-07-29.
//  Copyright © 2018 . All rights reserved.
//

import Foundation

struct Deque<T> {
    private var array = [T?]()
    private var head: Int
    private var frontCapacity: Int
    private let originalCapacity: Int
    
    //MARK: INITIALIZER
    public init(_ capacity: Int = 10) {
        self.frontCapacity = max(capacity, 1)
        self.originalCapacity = self.frontCapacity
        self.array = [T?](repeating: nil, count: capacity)
        self.head = capacity
    }
    
    //MARK: USEFUL VARIABLES
    public var isEmpty: Bool {
        return self.array.count == 0
    }
    public var count: Int {
        return self.array.count - head
    }
    
    
    
    //MARK: MUTATING FUNCTIONS
    public mutating func enqueue(_ element: T) {
        self.array.append(element)
    }
    public mutating func enqueueFront(_ element: T) {
        if self.head == 0 {
            self.frontCapacity *= 2
            let emptySpace = [T?](repeating: nil, count: self.frontCapacity)
            self.array.insert(contentsOf: emptySpace, at: 0)
            self.head = self.frontCapacity
        }
        
        self.head -= 1
        self.array[self.head] = element
    }
    public mutating func dequeue()-> T? {
        guard self.head < self.array.count, let element = self.array[self.head] else { return nil }
        self.array[self.head] = nil
        self.head += 1
        
        if self.frontCapacity >= self.originalCapacity && self.head >= self.frontCapacity*2 {
            let amountToRemove = self.frontCapacity + self.frontCapacity/2
            self.array.removeFirst(amountToRemove)
            self.head -= amountToRemove
            self.frontCapacity /= 2
        }
        
        return element
    }
    public mutating func dequeueBack()-> T? {
        if self.isEmpty {
            return nil
        }else {
            return self.array.removeLast()
        }
    }
    
    
    //MARK: PEEKING FUNCTIONS
    public func peekFront()-> T? {
        if self.isEmpty {
            return nil
        }else {
            return self.array[head]
        }
    }
    public func peekBack()-> T? {
        if self.isEmpty {
            return nil
        }else {
            return self.array.last!
        }
    }
}
