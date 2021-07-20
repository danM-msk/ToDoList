//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 08.06.2021.
//

import Foundation

enum Importance: String, Codable {
    case important
    case `default` = "basic"
    case unimportant = "low"
}

enum ToDoItemError: Error {
    case failedToCreateImportance(String)
}

struct ToDoItem {
    
    typealias Identifier = String
    
    let id: Identifier
    let text: String
    let completed: Bool
    let importance: Importance
    let deadline: Date?
    let createdAt: Int
    let updatedAt: Int?
    
    init(
        id: String = UUID().uuidString,
        text: String,
        completed: Bool = false,
        importance: Importance = .default,
        deadline: Date? = nil,
        createdAt: Int = Date().timeIntervalSince1970.toInt() ?? 0,
        updatedAt: Int? = Date().timeIntervalSince1970.toInt()
    ) {
        self.id = id
        self.text = text
        self.importance = importance
        self.completed = completed
        self.deadline = deadline
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

extension ToDoItem {
    
    func with(importance: Importance) -> ToDoItem {
        return ToDoItem(
            id: self.id,
            text: self.text,
            completed: self.completed,
            importance: importance,
            deadline: self.deadline,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
    
    func with(updatedAt: Int?) -> ToDoItem {
        return ToDoItem(
            id: self.id,
            text: self.text,
            completed: self.completed,
            importance: self.importance,
            deadline: self.deadline,
            createdAt: self.createdAt,
            updatedAt: updatedAt
        )
    }
}

extension ToDoItem: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case completed = "done"
        case importance
        case deadline = "deadline"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        
        switch importance {
        case .default:
            try container.encode("basic", forKey: .importance)

        case .important:
            try container.encode("important", forKey: .importance)
            
        case .unimportant:
            try container.encode("low", forKey: .importance)
        }
        
        try container.encode(completed, forKey: .completed)
        try container.encode(deadline, forKey: .deadline)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        text = try values.decode(String.self, forKey: .text)
        
        let importanceString = try values.decode(String.self, forKey: .importance)
        switch importanceString {
        case "basic":
            importance = .default
            
        case "important":
            importance = .important
            
        case "low":
            importance = .unimportant
            
        default:
            importance = .default
        }
        
        completed = try values.decode(Bool.self, forKey: .completed)
        if let deadlineTimestamp = try values.decode(Int?.self, forKey: .deadline) {
            deadline = Date(timeIntervalSince1970: TimeInterval(deadlineTimestamp))
        } else {
            deadline = nil
        }
        
        createdAt = try values.decode(Int.self, forKey: .createdAt)
        
        let updatedAtOptional = try values.decode(Int?.self, forKey: .updatedAt)
        self.updatedAt = updatedAtOptional ?? nil
        
    }
}
