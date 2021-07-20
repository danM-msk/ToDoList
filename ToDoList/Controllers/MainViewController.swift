//
//  MainViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 18.06.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
    let addButton = UIButton()
    let titleLabel = UILabel()
    let doneLabel = UILabel()
    let showButton = UIButton()
    
    let networkingService = DefaultNetworkingService.instance
    let cache = FileCache.instance
    
    public var showDoneToDos = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTitleLabel()
        configureDoneLabel()
        configureShowButton()
        configureTableView()
        configureAddButton()
    }
    
    public func reloadTableViewData() {
        tableView.reloadData()
    }
    
    @objc func showButtonDidTap() {
        showDoneToDos.toggle()
        tableView.reloadData()
    }
    
    @objc func addButtonDidTap() {
        let addViewController = AddTaskViewController()
        addViewController.completion = {
            self.tableView.reloadData()
        }
        
        let navigationViewController = UINavigationController(rootViewController: addViewController)
        present(navigationViewController, animated: true)
    }
}
