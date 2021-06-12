//
//  ToDoItem+ParsingJson.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 11.06.2021.
//

import Foundation

extension ToDoItem {
    var json: Any {
        get {
            do {
                var itemDictionary: [String: Any] = [
                    "id": id,
                    "text": text,
                ]
                if priority != .Default {
                    itemDictionary["priority"] = priority.toJsonValue()
                }
                if let deadline = deadline {
                    itemDictionary["deadline"] = String(deadline.timeIntervalSince1970)
                }
                let jsonData = try JSONSerialization.data(withJSONObject: itemDictionary, options: [])
                return String(data: jsonData, encoding: .ascii) ?? fatalError("json encoding failed")
            } catch let error {
                print(error)
                return error
            }
        }
    }
    
    
    
//    static func parse(json: Any) -> TodoItem? {
//        
//    }
        
    }


//protocol ParsingJSON {
//    static func parse(json: Any) -> ToDoItem?
//    var json: Any { get }
//}
