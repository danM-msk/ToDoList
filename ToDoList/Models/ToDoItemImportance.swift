//
//  ToDoItemPriority.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 12.06.2021.
//

import Foundation

enum ToDoItemImportance: JSONable, Equatable {
    case normal
    case unimportant
    case important
    
    var json: Any? {
        get {
            switch self {
            case .important:
                return "important"
            case .unimportant:
                return "unimportant"
            default:
                return "null"
            }
        }
    }
    
    static func parse(json: Any) -> ToDoItemImportance? {
        guard let jsonString = json as? String else {
            return nil
        }
        switch jsonString {
        case "important":
            return .important
        case "unimportant":
            return .unimportant
        default:
            return nil
        }
    }
}
