//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 08.06.2021.
//

import Foundation

struct ToDoItem {
    var id: String
    let text: String
    let priority: ToDoItemPriority
    let deadline: Date?
    
    init(id: String?, text: String, priority: ToDoItemPriority?, deadline: Date?) {
        if let extId = id {
            self.id = extId
        } else {
            self.id = ToDoItem.generateID()
        }
        
        self.text = text
        
        if let priority = priority {
            self.priority = priority
        } else {
            self.priority = .Default
        }
        
        self.deadline = deadline
    }
    
    init (text: String, priority: ToDoItemPriority?, deadline: Date?) {
        self.init(id: nil, text: text, priority: priority, deadline: deadline)
    }
    
    fileprivate static func generateID() -> String {
        return UUID().uuidString
    }
}
