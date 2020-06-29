//
//  Node.swift
//  tbatsuur
//
//  Created by tbatsuur on 2018-04-29.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

public class Node<T> {
    //Properties
    var value: T
    var nextNode: Node<T>?
    weak var previousNode: Node<T>?
    
    //Initializers
    init(value: T) {
        self.value = value
    }
}
