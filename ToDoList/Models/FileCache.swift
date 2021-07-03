//
//  FileCache.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 12.06.2021.
//

import Foundation

class FileCache {
    
    private var cache = [
        ToDoItem(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", priority: .normal, deadline: nil, isDone: false),
        ToDoItem(text: "This task is done", priority: .normal, deadline: nil, isDone: true),
        ToDoItem(text: "This task is unimportant", priority: .unimportant, deadline: nil, isDone: false),
        ToDoItem(text: "This task has is important and has deadline", priority: .important, deadline: Date().addWeek(1), isDone: false),
        ToDoItem(text: "This task is done", priority: .normal, deadline: nil, isDone: true),
        ToDoItem(text: "This task is done", priority: .normal, deadline: nil, isDone: true),
        ToDoItem(text: "This task is done", priority: .normal, deadline: nil, isDone: true),
        ToDoItem(text: "This task is done", priority: .normal, deadline: nil, isDone: true),
        ToDoItem(text: "This task is done", priority: .normal, deadline: nil, isDone: true),
        ToDoItem(text: "This task is done", priority: .normal, deadline: nil, isDone: true),
        ToDoItem(text: "This task is done", priority: .normal, deadline: nil, isDone: true),
        ToDoItem(text: "This task is done", priority: .normal, deadline: nil, isDone: true),
        ToDoItem(text: "This task is done", priority: .normal, deadline: nil, isDone: true)
    ]
    
    public static let instance = FileCache()
    
    public var todos: [ToDoItem] {
        get { return self.cache }
    }
    
    public var activeTodos: [ToDoItem] {
        get { self.cache.filter { $0.isDone == true } }
    }
    
    public var count: Int {
        get { self.cache.count }
    }
    
    subscript(uuid: String) -> ToDoItem? {
        get {
            return self.cache.first(where: { item in
                item.id == uuid
            })
        }
        //        set(new) {
        //            self.cache[i].isDone.toggle()
        //            }
    }
    
    public func addToDo(_ item: ToDoItem) {
        self.cache.append(item)
    }
    
    public func removeToDo(uuid: String) {
        self.cache.removeAll(where: { item in
            item.id == uuid
        })
    }
    
    public func saveToLocalDirectory() {
        
        let path = getDocumentsDirectory().appendingPathComponent("/filecache")
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: cache, requiringSecureCoding: false)
            try data.write(to: path)
        } catch {
            print("Couldn't write file")
        }
    }
    
    public func readFromLocalDirectory() {
        
        var readData: Data? = nil
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            
            
            for item in items {
                
                readData = item.data(using: .utf8)
            }
        } catch {
        }
        
        do {
            if let data = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(readData!) as? ToDoItem {
                cache.append(data)
            }
        } catch {
            print("Couldn't read file.")
        }
    }
    
    // MARK: Private
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
