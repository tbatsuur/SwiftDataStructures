//
//  Queue.swift
//  tbatsuur
//
//  Created by tbatsuur on 2018-04-29.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

public struct Queue<T> {
    //Properties
    fileprivate var list = LinkedList<T>()
    
    //Mutating methods
    public mutating func enqueue(_ element: T) {
        self.list.append(value: element)
    }
    public mutating func dequeue()-> T? {
        if !self.list.isEmpty {
            if let element = self.list.first {
                return self.list.remove(node: element)
            }else {
                print("List has no first item, also empty")
                return nil
            }
        }else {
            print("List empty")
            return nil
        }
    }
    //Non mutating methods
    public func peek()-> T? {
        return self.list.first?.value
    }
    
    //Calculated properties
    public var isEmpty: Bool {
        return self.list.isEmpty
    }
}


extension Queue: CustomStringConvertible {
    public var description: String {
        return self.list.description
    }
    
}
