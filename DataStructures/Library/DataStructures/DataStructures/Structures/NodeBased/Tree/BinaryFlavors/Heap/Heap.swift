//
//  Heap.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-07-24.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

enum HeapTypes: String {
    case Maximum = "Parents are bigger"
    case Minimum = "Parents are smaller"
}
/**
 Common uses
    * To build priority queues
    * To support heap sorts
    * To compute minimum or a maximum quickly
 
 Characteristics
    * The root of the heap has the maximum or minimum element, but the sort order of other elements are not predictable
 */
public struct Heap<Element> {
    var elements = [Element]()
    let priorityFunction: (Element, Element)-> Bool //Returns true if first item is of higher priority
    
    
    
    //MARK: INITIALIZERS
    init(elements: [Element] = [], priorityFunction: @escaping (Element, Element)-> Bool) {
        self.elements = elements
        self.priorityFunction = priorityFunction
        buildHeap()
    }
    
    
    
    
    
    
    //MARK: CALCULATED VARIABLES
    var height: Int {
        return Int(floor(log2(Double(self.elements.count))))
    }
    
    
    
    
    //MARK: MUTATING FUNCTIONS
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex else {
            return
        }
        self.elements.swapAt(firstIndex, secondIndex)
    }
    mutating func enqueue(_ element: Element) {
        self.elements.append(element)
        self.siftUp(elementAtIndex: self.count - 1)
    }
    mutating func siftUp(elementAtIndex index: Int) {
        let parent = getParent(index: index)
        guard !isRoot(index), isHigherPriority(at: index, than: parent) else {
            return
        }
        swapElement(at: index, with: parent)
        siftUp(elementAtIndex: parent)
    }
    mutating func dequeue()-> Element? {
        guard !isEmpty else {
            return nil
        }
        swapElement(at: 0, with: (count - 1))
        let element = self.elements.removeLast()
        if !isEmpty {
            siftDown(elementAtIndex: 0)
        }
        return element
    }
    mutating func siftDown(elementAtIndex index: Int) {
        let childIndex = highestPriorityIndex(for: index)
        if index == childIndex {
            return
        }
        swapElement(at: index, with: childIndex)
        siftDown(elementAtIndex: childIndex)
    }
    mutating func buildHeap() {
        for index in (0 ..< count / 2).reversed() {
            siftDown(elementAtIndex: index)
        }
    }
    
    
    //MARK: INDEX CALCULATOR
    func getParent(index: Int)-> Int {
        return Int(floor(Double((index - 1)/2)))
    }
    func getLeft(index: Int)-> Int {
        return 2 * index + 1
    }
    func getRight(index: Int)-> Int {
        return getLeft(index: index) + 1
    }
    func isRoot(_ index: Int)-> Bool {
        return (index == 0)
    }
    
    
    
    //MARK: COMPARE FUNCTIONS
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int)-> Bool {
        return priorityFunction(self.elements[firstIndex], self.elements[secondIndex])
    }
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int)-> Int {
        guard childIndex < self.count && self.isHigherPriority(at: childIndex, than: parentIndex) else {
            return parentIndex
        }
        return childIndex
    }
    func highestPriorityIndex(for parent: Int)-> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent, and: self.getLeft(index: parent)), and: self.getRight(index: parent))
    }
    

    
    
    
    //MARK: SIMPLE FUNCTIONS
    var count: Int {
        return self.elements.count
    }
    var isEmpty: Bool {
        return self.elements.isEmpty
    }
    
    //MARK: HEAP FUNCTIONS
    func peek()-> Element? {
        return self.elements.first
    }
}
