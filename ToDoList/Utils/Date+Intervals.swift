//
//  Date+Intervals.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 12.06.2021.
//

import Foundation

extension Date {
    func addDays(_ numberOfDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberOfDays, to: self)!
    }
    
    func addWeeks(_ numberOfWeeks: Int) -> Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: numberOfWeeks, to: self)!
    }
    
    // TODO: add months
}
