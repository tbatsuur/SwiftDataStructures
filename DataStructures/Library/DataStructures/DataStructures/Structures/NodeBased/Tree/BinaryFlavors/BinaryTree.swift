//
//  BinaryTreeNode.swift
//  tbatsuur 
//
//  Created by tbatsuur on 2018-05-03.
//  Copyright © 2018 tbatsuur Inc. All rights reserved.
//

import Foundation

/** Reference implementation
 */
//class BinaryTreeNode<T> {
//    var value: T
//    var leftChild: BinaryTreeNode?
//    var rightChild: BinaryTreeNode?
//
//    init(value: T) {
//        self.value = value
//    }
//}


enum BinaryTree<T: Comparable> {
    case empty
    indirect case node(BinaryTree, T, BinaryTree)
    
    
//    private mutating func naiveInsert(newValue: T) {
//        guard case  .node(var left, let value, var right) =  self else {
//            self = .node(.empty, newValue, .empty)
//            return
//        }
//
//        if newValue < value {
//            left.naiveInsert(newValue: newValue)
//        }else {
//            right.naiveInsert(newValue: newValue)
//        }
//    }
    
    
    //MARK: INSERTION
    mutating func insert(newValue: T) {
        self = self.newTreeWith(insertedValue: newValue)
    }
    private func newTreeWith(insertedValue: T)-> BinaryTree {
        switch self {
        case .empty:
            return BinaryTree.node(.empty, insertedValue, .empty)
        case let .node(left, value, right):
            if insertedValue < value {
                return BinaryTree.node(left.newTreeWith(insertedValue: insertedValue), value, right)
            }else {
                return BinaryTree.node(left, value, right.newTreeWith(insertedValue: insertedValue))
            }
        }
    }
    
    
    
    //MARK: STATISTICS
    var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
    
    
    
    //MARK: TRAVERSALS
    func traverseInOrder(process: (T)-> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            left.traverseInOrder(process: process)
            process(value)
            right.traverseInOrder(process: process)
        }
    }
    func traversePreOrder( process: (T) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            process(value)
            left.traversePreOrder(process: process)
            right.traversePreOrder(process: process)
        }
    }
    func traversePostOrder( process: (T) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            left.traversePostOrder(process: process)
            right.traversePostOrder(process: process)
            process(value)
        }
    }
    
    
    
    
    
    //MARK: SEARCH
    func search(searchValue: T)-> BinaryTree? {
        switch self {
        case .empty:
            return nil
        case let .node(left, value, right):
            if searchValue == value {
                return self
            }
            
            if searchValue < value {//This part makes it very efficient, because you skip over the rest of the tree
                return left.search(searchValue: searchValue)
            }else {
                return right.search(searchValue: searchValue)
            }
        }
    }
}


extension BinaryTree: CustomStringConvertible {
    var description: String {
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left = [" + left.description + "], right = [" + right.description + "]"
        default:
            return ""
        }
    }
}
