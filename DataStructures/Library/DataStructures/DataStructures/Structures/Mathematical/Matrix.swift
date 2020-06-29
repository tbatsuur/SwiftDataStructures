//
//  Matrix.swift
//  DataStructures
//
//  Created by tbatsuur on 2018-05-12.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import Foundation

struct Matrix<T> {
    var data: [[T]]
    var columns: Int
    var rows: Int
    var array: [T]
    
    public init(allInitialValues: T, rows: Int, columns: Int) {
        self.data = [[T]](repeating: [T](repeating: allInitialValues, count: columns), count: rows)
        self.array = .init(repeating: allInitialValues, count: rows*columns)
        self.columns = columns
        self.rows = rows
    }
    public subscript(column: Int, row: Int)-> T {
        get {
            precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            print(self.data[row][column])
            return array[row*columns + column]
        }
        set {
            precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            self.data[row][column] = newValue
            array[row*columns + column] = newValue
        }
    }
}

extension Matrix: CustomStringConvertible {
    var description: String {
        var result = ""
        for row in self.data {
            result = result + "\(row)" + "\n"
        }
        return result
    }
}
