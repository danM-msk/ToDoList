//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 08.06.2021.
//

import Foundation

struct ToDoItem: Equatable {
    var id: String
    let text: String
    let importance: ToDoItemImportance
    let deadline: Date?
    var isDone = false
    var updatedAt: Int?
    var isDirty = false
    
    init(id: String?, text: String, priority: ToDoItemImportance?, deadline: Date?, isDone: Bool) {
        if let extId = id {
            self.id = extId
        } else {
            self.id = ToDoItem.generateID()
        }
        
        self.text = text
        
        if let priority = priority {
            self.importance = priority
        } else {
            self.importance = .normal
        }
        
        self.deadline = deadline

    }
    
    init (text: String, priority: ToDoItemImportance?, deadline: Date?, isDone: Bool) {
        self.init(id: nil, text: text, priority: priority, deadline: deadline, isDone: false)
    }
    
    fileprivate static func generateID() -> String {
        return UUID().uuidString
    }
}
