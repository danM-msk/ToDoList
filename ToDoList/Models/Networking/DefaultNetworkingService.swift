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
    
    func syncItems(ids: [String], items: [ToDoItem], completion: @escaping (ToDoItemsResult) -> Void) {
        func complete(_ result: ToDoItemsResult) {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        queue.async { [weak self] in
            guard let self = self else { return }
            let urlString = "\(Self.baseURL)/tasks/"
            print("Started synchronizing...")
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
            
            var dict: [String: Any] = [:]
            dict["deleted"] = ids
//             TODO:
//            dict["other"] = items.map({$0.})
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: dict, options: []), JSONSerialization.isValidJSONObject(dict)
            else {
                complete(.failure(.serializationError("serialization error" as! Error)))
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
}
