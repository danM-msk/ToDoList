//
//  DefaultNetworkingService.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 01.07.2021.
//

import Foundation

final class DefaultNetworkingService: NetworkingService {
    
    public static let instance = DefaultNetworkingService()
    
    private static let baseURL = "https://d5dps3h13rv6902lp5c8.apigw.yandexcloud.net"
    private static let token = "LTY4MjIyMDcwNjc3MTMwNzc5OTY"
    
    let urlSession: URLSession = {
        var configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    private let queue = DispatchQueue.global(qos: .utility)
    
//    func getItems(completion: @escaping (ToDoItemsResult) -> Void) {
//        func complete(_ result: ToDoItemsResult) {
//            DispatchQueue.main.async {
//                completion(result)
//            }
//        }
//
//        queue.async { [weak self] in
//            guard let self = self else { return }
//            let urlString = "\(Self.baseURL)/tasks"
//            guard let url = URL(string: urlString) else {
//                complete(.failure(.failedToCreateUrl(urlString)))
//                return
//            }
//            var request = URLRequest(url: url)
//            request.httpMethod = HTTPMethod.GET.rawValue
//            request.allHTTPHeaderFields = [
//                "Authorization" : "Bearer \(Self.token)",
//                "Content-Type" : "application/json"
//            ]
//
//            let task = self.urlSession.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    complete(.failure(.networkingError(error)))
//                    return
//                }
//
//                guard let response = response as? HTTPURLResponse, let data = data else {
//                    complete(.failure(.noResponseData))
//                    return
//                }
//
//                guard response.statusCode >= 200, response.statusCode < 300 else {
//                    complete(.failure(.invalidStatusCode(response.statusCode)))
//                    return
//                }
//
//                let jsonDecoder = JSONDecoder()
//                do {
//                    let toDoItemDTOs = try jsonDecoder.decode([ToDoItemDTO].self, from: data)
//                    let toDoItems = try toDoItemDTOs.map { try ToDoItem.init(withDTO: $0) }
//                    complete(.success(toDoItems))
//                } catch {
//                    complete(.failure(.deserializationError(error)))
//                }
//            }
//            task.resume()
//        }
//    }
    
    
    func createItem(_ toDoItem: ToDoItem, completion: @escaping (ToDoItemResult) -> Void) {
        func complete(_ result: ToDoItemResult) {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        queue.async { [weak self] in
            guard let self = self else { return }
            let urlString = "\(Self.baseURL)/tasks"
            guard let url = URL(string: urlString) else {
                complete(.failure(.failedToCreateUrl(urlString)))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.POST.rawValue
            request.allHTTPHeaderFields = [
                "Authorization" : "Bearer \(Self.token)",
                "Content-Type" : "application/json"
            ]
            
            guard let httpBody = try? JSONEncoder().encode(toDoItem) else {
                complete(.failure(.serializationError("encoding error" as! Error)))
                return
            }
            request.httpBody = httpBody
            let task = self.urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    complete(.failure(.networkingError(error)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, let _ = data else {
                    complete(.failure(.noResponseData))
                    return
                }
                
                guard response.statusCode >= 200, response.statusCode < 300 else {
                    complete(.failure(.invalidStatusCode(response.statusCode)))
                    return
                }
            }
            task.resume()
        }
    }
    
    func updateItem(_ toDoItem: ToDoItem, completion: @escaping (ToDoItemResult) -> Void) {
        func complete(_ result: ToDoItemResult) {
            DispatchQueue.main.async {
                completion(result)
            }
        }

        queue.async { [weak self] in
            guard let self = self else { return }
            let urlString = "\(Self.baseURL)/tasks/\(toDoItem.id)"
            guard let url = URL(string: urlString) else {
                complete(.failure(.failedToCreateUrl(urlString)))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.PUT.rawValue
            request.allHTTPHeaderFields = [
                "Authorization" : "Bearer \(Self.token)",
                "Content-Type" : "application/json"
            ]

//            guard let httpBody = try? JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
//            do {
//                request.httpBody = try jsonEncoder.encode(toDoItem.asDto)
//            } catch {
//                complete(.failure(.serializationError(error)))
//            }

            let task = self.urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    complete(.failure(.networkingError(error)))
                    return
                }

                guard let response = response as? HTTPURLResponse, let data = data else {
                    complete(.failure(.noResponseData))
                    return
                }

                guard response.statusCode >= 200, response.statusCode < 300 else {
                    complete(.failure(.invalidStatusCode(response.statusCode)))
                    return
                }
            }
            task.resume()
        }
    }

    
    func deleteItem(with id: ToDoItem.Identifier, completion: @escaping (ToDoItemResult) -> Void) {
        func complete(_ result: ToDoItemResult) {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        queue.async { [weak self] in
            guard let self = self else { return }
            let urlString = "\(Self.baseURL)/tasks/\(id)"
            guard let url = URL(string: urlString) else {
                complete(.failure(.failedToCreateUrl(urlString)))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.DELETE.rawValue
            request.allHTTPHeaderFields = [
                "Authorization" : "Bearer \(Self.token)",
                "Content-Type" : "application/json"
            ]
            
            let task = self.urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    complete(.failure(.networkingError(error)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, let _ = data else {
                    complete(.failure(.noResponseData))
                    return
                }
                
                guard response.statusCode >= 200, response.statusCode < 300 else {
                    complete(.failure(.invalidStatusCode(response.statusCode)))
                    return
                }
            }
            task.resume()
        }
    }
    
    //TODO: add func syncToDoItems
}
