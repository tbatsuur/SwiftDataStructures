//
//  Vector.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-05-03.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

struct GeometricalVector {
    var pointA: CartesianPoint = CartesianPoint(x: 0.0, y: 0.0)
    var pointB: CartesianPoint = CartesianPoint(x: 0.0, y: 0.0)

    var length: Double {
        get {
            return distance(pointA: pointA, pointB: pointB)
        }
    }
}
