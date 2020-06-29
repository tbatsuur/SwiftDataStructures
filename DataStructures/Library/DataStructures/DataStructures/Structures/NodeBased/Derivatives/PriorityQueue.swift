//
//  PriorityQueue.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-07-29.
//  Copyright © 2018 . All rights reserved.
//

import Foundation

enum PriorityQueueType: String {
    case Max = "Maximum priority item first"
    case Min = "Minimum priority item first"
}

/**
 Applications
    * Event driven simulations
    * Calculate minimum cost with Dijkstra
    * Huffman coding for data compression
    * Pathfinding for AI
    * Many others
 
 Common Operations
    * Enqueue
    * Dequeue
    * Find minimum
    * Find maximum
    * Change priority
 
 Different ways to implement this bitch
    * Sorted array
    * Balanced binary search tree
    * Heap
 */
struct PriorityQueue<T> {
    fileprivate var heap: EfficientHeap<T>
    
    public init(sort: @escaping (T, T) -> Bool) {
        heap = EfficientHeap(sort: sort)
    }

    
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    public var count: Int {
        return heap.count
    }
    
    
    //MARK: ENQUEUE, DEQUEUE
    public func peek() -> T? {
        return heap.peek()
    }
    public mutating func enqueue(element: T) {
        heap.insert(element)
    }
    public mutating func dequeue() -> T? {
        return heap.remove()
    }
    public mutating func changePriority(index i: Int, value: T) {
        return heap.replace(index: i, value: value)
    }
}
