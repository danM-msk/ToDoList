//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by Daniyar Mamadov on 04.06.2021.
//

import XCTest
@testable import ToDoList

class ToDoListTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJsonEncodeAndDecode() throws {
        let now = Date()
        let weekAfter = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: now)
        
        let todoItem = ToDoItem(text: "content here", priority: .unimportant, deadline: weekAfter)
        let jsonToDoItem = todoItem.json
        let secondTodoItem = ToDoItem.parse(json: jsonToDoItem)
        XCTAssertNotNil(secondTodoItem)
        
        XCTAssertEqual(secondTodoItem == todoItem, true)
        print(todoItem.id)
        print(secondTodoItem!.id)
        print(todoItem.text)
        print(secondTodoItem!.text)
        print(todoItem.priority)
        print(secondTodoItem!.priority)
        print(todoItem.deadline?.timeIntervalSince1970)
        print(secondTodoItem!.deadline?.timeIntervalSince1970)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
