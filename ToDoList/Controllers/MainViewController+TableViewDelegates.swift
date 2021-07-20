//
//  MainViewController+TableViewDelegates.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 20.07.2021.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showDoneToDos ? FileCache.instance.todos.count + 1 : FileCache.instance.activeTodos.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: AddItemCell.identifier, for: indexPath) as! AddItemCell
            cell.onTextDidChange = { text in
                let task = ToDoItem(text: text, completed: false, importance: .default, createdAt: Date().timeIntervalSince1970.toInt() ?? 0)
                self.cache.addToDo(task)
                self.networkingService.createItem(task) { result in
                    switch result {
                    case .success(_):
                        print("success")
                    case .failure(let error):
                        print(error)
                    }
                }
                self.tableView.reloadData()
            }
            return cell
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.todo = showDoneToDos ? FileCache.instance.todos[indexPath.row] : FileCache.instance.activeTodos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
//                        let todoID = FileCache.instance.todos[indexPath.row].id
//                        FileCache.instance[todoID]?.isDone.toggle()
            completionHandler(true)
        }
        doneAction.image = UIImage(systemName: "checkmark.circle.fill")
        doneAction.backgroundColor = .systemGreen
        let configuration = UISwipeActionsConfiguration(actions: [doneAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            let todoID = self.showDoneToDos ? FileCache.instance.todos[indexPath.row].id : FileCache.instance.activeTodos[indexPath.row].id
            FileCache.instance.removeToDo(uuid: todoID)
            self.networkingService.deleteItem(with: todoID) { result in
                switch result {
                case .success(_):
                    print("success")
                case .failure(let error):
                    print(error)
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        let infoAction = UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in
//            let viewControllerToPresent = AddTaskViewController()
//            self.present(viewControllerToPresent, animated: true, completion: nil)
            completionHandler(true)
        }
        infoAction.image = UIImage(systemName: "info.circle.fill")
        infoAction.backgroundColor = .systemGray
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, infoAction])
        return configuration
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat { return UITableView.automaticDimension }
}
