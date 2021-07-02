//
//  DefaultNetworkingService.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 01.07.2021.
//

import Foundation

class DefaultNetworkingService: NetworkingService {
    
    let url = "https://d5dps3h13rv6902lp5c8.apigw.yandexcloud.net"
    
    func get(with url: String, completion: @escaping ([ToDoItem], Error?) -> Void) {
        var session: URLSession {
            let session = URLSession(configuration: .default)
            session.configuration.timeoutIntervalForRequest = 30.0
            return session
        }
    }
    
//    var urlRequest = URLRequest(url: url)
    
}
