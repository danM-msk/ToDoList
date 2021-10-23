//
//  NetworkingServiceProtocol.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 14.07.2021.
//

import Foundation

typealias ToDoItemResult = Result<ToDoItem, NetworkingServiceError>
typealias ToDoItemsResult = Result<[ToDoItem], NetworkingServiceError>

protocol NetworkingService {
//    
//    func getItems(
//        completion: @escaping (ToDoItemsResult) -> Void
//    )
    
    func createItem(
        _ toDoItem: ToDoItem,
        completion: @escaping (ToDoItemResult) -> Void
    )
    
    func updateItem(
        _ toDoItem: ToDoItem,
        completion: @escaping (ToDoItemResult) -> Void
    )
    
    func deleteItem(
        with id: ToDoItem.Identifier,
        completion: @escaping (ToDoItemResult) -> Void
    )
}

enum NetworkingServiceError: Error {
    
    case failedToCreateUrl(String)
    case networkingError(Error)
    case noResponseData
    case deserializationError(Error)
    case serializationError(Error)
    case invalidStatusCode(Int)
}
