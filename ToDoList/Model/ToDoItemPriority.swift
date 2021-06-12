//
//  ToDoItemPriority.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 12.06.2021.
//

import Foundation

protocol Jsonable {
    func toJsonValue() -> String
    func fromJsonString(_ jsonString: String) -> Self?
}

enum ToDoItemPriority: Jsonable {
    case Default
    case Unimportant
    case Important
    
    func toJsonValue() -> String {
        switch self {
        case .Important:
            return "important"
        case .Unimportant:
            return "unimportant"
        default:
            return "null"
        }
    }
    
    func fromJsonString(_ jsonString: String) -> ToDoItemPriority? {
        switch jsonString {
        case "important":
            return .Important
        case "unimportant":
            return .Unimportant
        default:
            return nil
        }
    }
}
