//
//  TaskModel.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 18.06.2021.
//

import Foundation

class TaskModel {
    static let instance = TaskModel()
    var tasks = [ToDoItem]()
}
