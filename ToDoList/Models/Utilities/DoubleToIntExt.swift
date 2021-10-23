//
//  DoubleToIntExt.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 20.07.2021.
//

import Foundation

extension Double {
    func toInt() -> Int? {
        guard (self <= Double(Int.max).nextDown) && (self >= Double(Int.min).nextUp) else {
            return nil
        }

        return Int(self)
    }
}
