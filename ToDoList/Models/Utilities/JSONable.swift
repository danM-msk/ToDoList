//
//  JSONable.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 12.06.2021.
//

import Foundation

protocol JSONable {
    var json: Any { get }
    static func parse(json: Any) -> Self?
}
