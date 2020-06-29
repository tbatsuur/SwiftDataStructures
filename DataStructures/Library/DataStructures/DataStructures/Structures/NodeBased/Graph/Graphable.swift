//
//  Graphable.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-05-12.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

protocol Graphable {
    associatedtype Element: Hashable
    var description: CustomStringConvertible { get }
    
    func createVertex(data: Element)-> Vertex<Element>
    func add(_ type: EdgeType, from source: Vertex<Element>,to destination: Vertex<Element>, weight: Double)
    
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>)-> Double
    func edges(from source: Vertex<Element>)-> [Edge<Element>]?
}
