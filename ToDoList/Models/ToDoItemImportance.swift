////
////  ToDoItemPriority.swift
////  ToDoList
////
////  Created by Daniyar Mamadov on 12.06.2021.
////
//
//import Foundation
//
//@objc public enum ToDoItemImportance: Int64, JSONable, Equatable {
//    case unimportant    = 0
//    case normal         = 1
//    case important      = 2
//
//    var json: Any? {
//        get {
//            switch self {
//            case .important:
//                return "important"
//            case .unimportant:
//                return "unimportant"
//            default:
//                return "null"
//            }
//        }
//    }
//
//    static func parse(json: Any) -> ToDoItemImportance? {
//        guard let jsonString = json as? String else {
//            return nil
//        }
//        switch jsonString {
//        case "important":
//            return .important
//        case "unimportant":
//            return .unimportant
//        default:
//            return nil
//        }
//    }
//}
