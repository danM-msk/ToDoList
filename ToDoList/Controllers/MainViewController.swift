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
    
    let refreshControl = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTitle()
        configureTableView()
        configureAddButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        
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
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableView.automaticDimension
        
        let tableHeaderView = TableViewHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        tableView.tableHeaderView = tableHeaderView
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        self.refreshControl.beginRefreshing()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func configureAddButton() {
        addButton.layer.shadowColor = UIColor(named: "addButtonShadowColor")?.cgColor
        addButton.layer.shadowOpacity = 0.3
        addButton.layer.shadowOffset = .zero
        addButton.layer.shadowRadius = 20
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FileCache.instance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TaskCell
        let todo = FileCache.instance.todos[indexPath.row]
        cell.dateLabel?.text = todo.deadline?.description ?? "No date"
        cell.taskLabel?.text = todo.text
        if todo.isDone == true {
            cell.radioButton.setImage(UIImage(named: "radioButtonDone"), for: .normal)
        } else {
            cell.radioButton.setImage(UIImage(named: "radioButtonDefault"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
//            let todoID = FileCache.instance.todos[indexPath.row].id
//            FileCache.instance[todoID]?.isDone.toggle()
            completionHandler(true)
        }
        doneAction.image = UIImage(systemName: "checkmark.circle.fill")
        doneAction.backgroundColor = .systemGreen
        
        let configuration = UISwipeActionsConfiguration(actions: [doneAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            let todoID = FileCache.instance.todos[indexPath.row].id
            FileCache.instance.removeToDo(uuid: todoID)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        let infoAction = UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in
            let viewControllerToPresent = AddTaskViewController()
            self.present(viewControllerToPresent, animated: true, completion: nil)
            completionHandler(true)
        }
        infoAction.image = UIImage(systemName: "info.circle.fill")
        infoAction.backgroundColor = .systemGray
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, infoAction])
        return configuration
    }
    
    private func tableView(tableView: UITableView,
                           heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
