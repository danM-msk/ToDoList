//
//  ToDoItemPriority.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 12.06.2021.
//

import Foundation

enum ToDoItemPriority: JSONable {
    case Default
    case Unimportant
    case Important
    
    var json: Any {
        get {
            switch self {
            case .Important:
                return "important"
            case .Unimportant:
                return "unimportant"
            default:
                return "null"
            }
        }
    }
    
    static func parse(json: Any) -> ToDoItemPriority? {
        guard let jsonString = json as? String else {
            return nil
        }
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
