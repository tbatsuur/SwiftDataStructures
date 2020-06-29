//
//  Vertex.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-05-12.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

public struct Vertex<T: Hashable> {
    var data: T
}

extension Vertex: Hashable {
    public var hashValue: Int {
        return "\(data)".hashValue
    }
    static public func ==(lhs: Vertex, rhs: Vertex)-> Bool {
        return lhs.data == rhs.data
    }
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}
