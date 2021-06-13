//
//  Date+Intervals.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 12.06.2021.
//

import Foundation

extension Date {
    func addDay(_ numberOfDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberOfDays, to: self)!
    }
    
    func addWeek(_ numberOfWeeks: Int) -> Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: numberOfWeeks, to: self)!
    }
    
    func addMonth(_ numberOfMonths: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)!
    }
}
