////
////  ToDoItem+CoreDataProperties.swift
////  
////
////  Created by Daniyar Mamadov on 06.07.2021.
////
////
//
//import Foundation
//import CoreData
//
//
//extension ToDoItem {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
//        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
//    }
//
//    @NSManaged public var id: String?
//    @NSManaged public var text: String?
//    @NSManaged public var importance: Int64
//    @NSManaged public var isDone: Bool
//    @NSManaged public var deadline: Date?
//    @NSManaged public var updatedAt: Int64
//    @NSManaged public var isDirty: Bool
//    
//    @NSManaged var toDoItemImportance: ToDoItemImportance
//
//
//}
