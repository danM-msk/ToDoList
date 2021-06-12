//
//  ToDoItem+JSONable.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 11.06.2021.
//

import Foundation

extension ToDoItem: JSONable {
    var json: Any {
        get {
            do {
                var itemDictionary: [String: Any] = [
                    "id": id,
                    "text": text,
                ]
                if priority != .Default {
                    itemDictionary["priority"] = priority.json
                }
                if let deadline = deadline {
                    itemDictionary["deadline"] = String(deadline.timeIntervalSince1970 / 100000 * 100000)
                }
                let jsonData = try JSONSerialization.data(withJSONObject: itemDictionary, options: [])
                return String(data: jsonData, encoding: .utf8) ?? fatalError("json encoding failed")
            } catch let error {
                print(error)
                return error
            }
        }
    }
    
    
    
    static func parse(json: Any) -> ToDoItem? {
        guard let dataString = json as? String else {
            return nil
        }
        let data = Data(dataString.utf8)
        
        do {
            guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else {
                return nil
            }
            guard let id = dict["id"] else { return nil }
            guard let text = dict["text"] else { return nil }
            var priority: ToDoItemPriority?
            var deadline: Date?
            
            if let priorityString = dict["priority"] {
                priority = ToDoItemPriority.parse(json: priorityString)
            }
            if let deadlineString = dict["deadline"] {
                if let utc = TimeInterval.init(deadlineString) {
                    deadline = Date(timeIntervalSince1970: utc)
                }
            }
            return ToDoItem.init(id: id, text: text, priority: priority, deadline: deadline)
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}

