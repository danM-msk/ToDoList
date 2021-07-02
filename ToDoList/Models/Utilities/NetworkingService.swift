//
//  NetworkingService.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 01.07.2021.
//

import Foundation

protocol NetworkingService {
    func get (with url: String, completion: @escaping ([ToDoItem], Error?) -> Void)
}
