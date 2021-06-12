//
//  FileCache.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 12.06.2021.
//

import Foundation

class FileCache {
    private var cache: [ToDoItem]? = nil
    
    public func addToDo(_ item: ToDoItem) {
        cache?.append(item)
    }
    
    public func removeToDo(uuid: String) {
        cache?.removeAll(where: { item in
            item.id == uuid
        })
    }
    
    subscript(uuid: String) -> ToDoItem? {
        get {
            return cache?.first(where: { item in
                item.id == uuid
            })
        }
    }
    
    internal func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    public func saveToLocalDirectory() {
        guard let cache = self.cache else {
            print("Cache is empty")
            return
        }
        
        let path = getDocumentsDirectory().appendingPathComponent("/filecache")

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: cache, requiringSecureCoding: false)
            try data.write(to: path)
        } catch {
            print("Couldn't write file")
        }
    }
    
    public func readFromLocalDirectory() {
        NSKeyedUnarchiver.init(forReadingFrom: <#T##Data#>)
        
        NSKeyedUnarchiver.unarchivedObject(ofClass: cache.self, from: <#T##Data#>)
        do {
            if let loadedStrings = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] {
                savedArray = loadedStrings
            }
        } catch {
            print("Couldn't read file.")
        }
    }
    
}
