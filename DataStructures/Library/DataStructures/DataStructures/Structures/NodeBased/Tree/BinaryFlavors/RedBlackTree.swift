//
//  RedBlackTree.swift
//  DataStructures
//
//  Created by tbatsuur on 2019-02-02.
//  Copyright © 2019 tbatsuur. All rights reserved.
//

import Foundation


//MARK: HELPERS
private enum RedBlackColor {
    case red
    case black
}
private enum Rotation {
    case left
    case right
}


//MARK: RED BLACK TREE
class RedBlackTree<T: Comparable> {
    //Shorten Code
    public typealias RedBlackNode = RedBlackTreeNode<T>
    
    fileprivate(set) var root: RedBlackNode
    fileprivate(set) var size = 0
    fileprivate let nullLeaf = RedBlackNode()
    
    public init() {
        self.root = self.nullLeaf
    }
}


//MARK: RED BLACK NODE
public class RedBlackTreeNode<T: Comparable>: Equatable {
    //Equatable Protocol Requirement
    public static func == (lhs: RedBlackTreeNode<T>, rhs: RedBlackTreeNode<T>) -> Bool {
        return lhs.key == rhs.key
    }
    
    
    
    //Shorten Code
    public typealias RedBlackNode = RedBlackTreeNode<T>
    //Variables
    fileprivate var color: RedBlackColor = .black
    fileprivate var key: T?
    var leftChild: RedBlackNode?
    var rightChild: RedBlackNode?
    fileprivate weak var parent: RedBlackNode?
    
    
    
    
    
    
    //Initializers
    public init(key: T?, leftChild: RedBlackNode?, rightChild: RedBlackNode?, parent: RedBlackNode?) {
        self.key = key
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.parent = parent
        
        self.leftChild?.parent = self
        self.rightChild?.parent = self
    }
    public convenience init(key: T?) {
        self.init(key: key, leftChild: RedBlackNode(), rightChild: RedBlackNode(), parent: RedBlackNode())
    }
    //Initialize the nullLeaf
    public convenience init() {
        self.init(key: nil, leftChild: nil, rightChild: nil, parent: nil)
        self.color = .black
    }
    
    
    
    
    //Node Recognizers
    var isRoot: Bool {
        return self.parent == nil
    }
    var isLeaf: Bool {
        return self.leftChild == nil && self.rightChild == nil
    }
    var isNullLeaf: Bool {
        return self.key == nil && self.isLeaf && self.color == .black
    }
    var isLeftChild: Bool {
        return self.parent?.leftChild === self
    }
    var isRightChild: Bool {
        return self.parent?.rightChild === self
    }
    
    
    //Node Relatives
    var grandParent: RedBlackNode? {
        return self.parent?.parent
    }
    var sibling: RedBlackNode? {
        if self.isLeftChild {
            return self.parent?.rightChild
        }else {
            return self.parent?.leftChild
        }
    }
    var uncle: RedBlackNode? {
        return self.parent?.sibling
    }
    
    
    
    
    
    //MARK: SEARCHING
    /**
        Returns the minimum key node of the current subtree
    */
    public func minimum()-> RedBlackNode? {
        if let left = self.leftChild {
            if !left.isNullLeaf {
                return left.minimum()
            }else {
                return self
            }
        }else {
            return self
        }
    }
    /**
        Returns the node with the maximum key of the current subtree
    */
    public func maximum()-> RedBlackNode? {
        if let right = self.rightChild {
            if !right.isNullLeaf {
                return right.maximum()
            }else {
                return self
            }
        }else {
            return self
        }
    }
    
    
    
    
    //MARK: FINDING NODE SUCCESSOR - Next largest key node
    public func getSuccessor()-> RedBlackNode? {
        //If node has right child
        if let right = self.rightChild {
            if !right.isNullLeaf {
                return right.minimum()
            }
        }
        var currentNode = self
        var parentNode = currentNode.parent
        while currentNode.isRightChild {
            if let parent = parentNode {
                currentNode = parent
            }
            parentNode = currentNode.parent
        }
        return parentNode
    }
}
