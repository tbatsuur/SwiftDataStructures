//
//  LinkedList.swift
//  tbatsuur
//
//  Created by tbatsuur on 2018-04-29.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

public class LinkedList<T> {
    //Properties
    fileprivate var head: Node<T>?
    private var tail: Node<T>?
    
    //Computed Values
    public var isEmpty: Bool {
        return (head == nil)
    }
    public var first: Node<T>? {
        return self.head
    }
    public var last: Node<T>? {
        return self.tail
    }
    
    //Methods
    public func append(value: T) {
        let newNode = Node(value: value)
        
        if let tailNode = tail {
            newNode.previousNode = tailNode
            tailNode.nextNode = newNode
        }else {
            head = newNode
        }
        
        self.tail = newNode
    }
    public func nodeAt(index: Int)-> Node<T>? {
        if index > 0 {
            var node = self.head
            var i = index
            
            while node != nil {
                if i == 0 {
                    return node
                }else {
                    i -= 1
                    node = node!.nextNode
                }
            }
        }
        return nil
    }
    public func removeAll() {
        self.head = nil
        self.tail = nil
    }
    public func remove(node: Node<T>)-> T {
        //=========================================
        //Just grab the pointers
        let previous = node.previousNode
        let next = node.nextNode
        
        
        //=========================================
        if let pr = previous {
            //Either last or middle, since previous exists
            //If last next will be nil, that's okay
            pr.nextNode = next
        }else {
            //Must have been head
            head = next
        }
        
        //=========================================
        //Next node's previous = current's previous
        //Since swift optional chaining no need for if statement
        next?.previousNode = previous
        
        //Must have been last item
        if next == nil {
            tail = previous
        }
        
        //=========================================
        /* Can be this optionally I think
        if let nt = next {
            //First or middle
            nt.previousNode = previous
        }else {
            //Must be last
            tail = previous
        }
         */
        
        
        //Nil both pointers to eliminate any leaks
        //=========================================
        node.previousNode = nil
        node.nextNode = nil
        
        
        //Pop sort of functionality
        //=========================================
        return node.value
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var text = "["
        var node = head
        while let currentNode = node {
            text += "\(currentNode.value)"
            node = currentNode.nextNode
            if node != nil {
                text += ", "
            }
        }
        return text + "]"
    }
}
