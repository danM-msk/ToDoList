//
//  FileCache.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 12.06.2021.
//

import Foundation

class FileCache {
    
    private var cache = [
        ToDoItem(text:
        """
            Многие думают, что Lorem Ipsum - взятый с потолка псевдо-латинский набор слов, но это не совсем так. Его корни уходят в один фрагмент классической латыни 45 года н.э., то есть более двух тысячелетий назад. Ричард МакКлинток, профессор латыни из колледжа Hampden-Sydney, штат Вирджиния, взял одно из самых странных слов в Lorem Ipsum, "consectetur", и занялся его поисками в классической латинской литературе. В результате он нашёл неоспоримый первоисточник Lorem Ipsum в разделах 1.10.32 и 1.10.33 книги "de Finibus Bonorum et Malorum" ("О пределах добра и зла"), написанной Цицероном в 45 году н.э. Этот трактат по теории этики был очень популярен в эпоху Возрождения. Первая строка Lorem Ipsum, "Lorem ipsum dolor sit amet..", происходит от одной из строк в разделе 1.10.32
        """, priority: .important, deadline: Date().addWeek(1), isDone: false),
        ToDoItem(text: "asqwqewqwe", priority: .important, deadline: nil, isDone: false),
        ToDoItem(text: "3 task qewqwe", priority: .normal, deadline: nil, isDone: true)
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
            // failed to read directory – bad permissions, perhaps?
        }
        
//        NSKeyedUnarchiver.init(forReadingFrom: <#T##Data#>)
//
//        NSKeyedUnarchiver.unarchivedObject(ofClass: cache.self, from: <#T##Data#>)
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
