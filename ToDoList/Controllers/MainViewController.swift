//
//  MainViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 18.06.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureTableView()
        configureAddButton()
    }
    
    func configureTitle() {
        title = "Мои дела"
        navigationController?.navigationBar.layoutMargins.left = 32
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 16
        
        // TODO: add height constraint and dynamic row height
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableView.automaticDimension
        
        let tableHeaderView = TableViewHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        tableView.tableHeaderView = tableHeaderView
    }
    
    func configureAddButton() {
        addButton.layer.shadowColor = UIColor(named: "addButtonShadowColor")?.cgColor
        addButton.layer.shadowOpacity = 0.3
        addButton.layer.shadowOffset = .zero
        addButton.layer.shadowRadius = 20
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FileCache.instance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TaskCell
        let todo = FileCache.instance.todos[indexPath.row]
        cell.dateLabel?.text = todo.deadline?.description ?? "date"
        cell.taskLabel?.text = todo.text
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        <#code#>
//    }
}
