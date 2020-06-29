//
//  TreeImplementations.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-10-29.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

class TreeImplementations {
    static let singleton = TreeImplementations()
    private init() {}
    
    func treeNodeImplementation() {
        let tree = TreeNode<String>(value: "beverages")
        
        //Tree
        let hotNode = TreeNode<String>(value: "hot")
        let coldNode = TreeNode<String>(value: "cold")
        
        //Hot
        let teaNode = TreeNode<String>(value: "tea")
        let coffeeNode = TreeNode<String>(value: "coffee")
        let chocolateNode = TreeNode<String>(value: "cocoa")
        
        //Tea
        let blackTeaNode = TreeNode<String>(value: "black")
        let greenTeaNode = TreeNode<String>(value: "green")
        let chaiTeaNode = TreeNode<String>(value: "chai")
        
        //Cold
        let sodaNode = TreeNode<String>(value: "soda")
        let milkNode = TreeNode<String>(value: "milk")
        
        //Soda
        let gingerAleNode = TreeNode<String>(value: "ginger ale")
        let bitterLemonNode = TreeNode<String>(value: "bitter lemon")
        
        tree.add(child: hotNode)
        tree.add(child: coldNode)
        
        hotNode.add(child: teaNode)
        hotNode.add(child: coffeeNode)
        hotNode.add(child: chocolateNode)
        
        coldNode.add(child: sodaNode)
        coldNode.add(child: milkNode)
        
        teaNode.add(child: blackTeaNode)
        teaNode.add(child: greenTeaNode)
        teaNode.add(child: chaiTeaNode)
        
        sodaNode.add(child: gingerAleNode)
        sodaNode.add(child: bitterLemonNode)
        
        print(tree.description)
    }
    
    func binaryTreeImplementation() {
        // leaf nodes
        let node5 = BinaryTree.node(.empty, "5", .empty)
        let nodeA = BinaryTree.node(.empty, "a", .empty)
        let node10 = BinaryTree.node(.empty, "10", .empty)
        let node4 = BinaryTree.node(.empty, "4", .empty)
        let node3 = BinaryTree.node(.empty, "3", .empty)
        let nodeB = BinaryTree.node(.empty, "b", .empty)
        
        // intermediate nodes on the left
        let Aminus10 = BinaryTree.node(nodeA, "-", node10)
        let timesLeft = BinaryTree.node(node5, "*", Aminus10)
        
        // intermediate nodes on the right
        let minus4 = BinaryTree.node(.empty, "-", node4)
        let divide3andB = BinaryTree.node(node3, "/", nodeB)
        let timesRight = BinaryTree.node(minus4, "*", divide3andB)
        
        // root node
        let tree = BinaryTree.node(timesLeft, "+", timesRight)
        print(tree)
    }
    
    func binarySearchTreeImplementation() {
        let tree = BinarySearchTree<Int>(value: 7)
        tree.insert(value: 2)
        tree.insert(value: 5)
        tree.insert(value: 10)
        tree.insert(value: 9)
        tree.insert(value: 1)
        
        let tree2 = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])
        print(tree2)
    }
    func binarySearchTreeImplementationAdvanced() {
        let tree = BinarySearchTree<Int>(value: 7)
        tree.insert(value: 2)
        tree.insert(value: 5)
        tree.insert(value: 10)
        tree.insert(value: 9)
        tree.insert(value: 1)
        print(tree.asString)
        print(self.findLevel(count: tree.count))
        print("====================================================")
        
        
        let tree2 = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1, 1, 8, 8, 99])
        print(tree2.asString)
        print(self.findLevel(count: tree2.count))
        print("====================================================")
        
        let tree3 = BinarySearchTree<String>(array: ["tojo", "ali", "karen", "chris"])
        print(tree3.asString)
        print(self.findLevel(count: tree3.count))
        print(tree3.count)
        //This starts to give me a linked list, motivation for RedBlackTree
    }
    private func testMembership(level: Int, testSubject: Int)-> Bool? {
        let value = Double(level)
        if let min = value.minimumForLevel, let max = value.sumOfEverythingBelow {
            let array = Int.getArray(from: min, to: max)
            if array.contains(testSubject) {
                return true
            }else {
                return false
            }
        }else {
            return nil
        }
    }
    /**
     This would only work for a priority queue, where the tree fills in a regular pattern from left to right
     */
    private func findLevel(count: Int)-> Int {
        var temp = 0
        while temp < 30 {
            if let test = testMembership(level: temp, testSubject: count) {
                if test == true {
                    print("Found in level: \(temp)")//Height
                    return temp
                }
            }
            temp += 1
        }
        return -1
    }
}
