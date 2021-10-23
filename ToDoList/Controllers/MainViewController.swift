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
    
    private var showDoneToDos = false
    
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
    
    func configureView() {
        view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Мои дела"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 88).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
    }
    
    func configureDoneLabel() {
        view.addSubview(doneLabel)
        doneLabel.text = "Выполнено: число"
        doneLabel.textAlignment = .left
        doneLabel.font = UIFont.systemFont(ofSize: 15)
        doneLabel.alpha = 0.3
        
        doneLabel.translatesAutoresizingMaskIntoConstraints = false
        doneLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18).isActive = true
        doneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
    }
    
    func configureShowButton() {
        view.addSubview(showButton)
        showButton.setTitle("Показать", for: .normal)
        showButton.setTitleColor(.systemBlue, for: .normal)
        showButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        showButton.contentHorizontalAlignment = .right
        showButton.addTarget(self, action: #selector(showButtonDidTap), for: .touchUpInside)
        
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 18).isActive = true
        showButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        showButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        showButton.widthAnchor.constraint(equalToConstant: 148).isActive = true
    }
    
    @objc func showButtonDidTap() {
        showDoneToDos.toggle()
        tableView.reloadData()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TaskCell.cellNibName, bundle: nil), forCellReuseIdentifier: TaskCell.identifier)
        tableView.register(AddItemCell.self, forCellReuseIdentifier: AddItemCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 68.0
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: showButton.bottomAnchor, constant: 6).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureAddButton() {
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        addButton.setImage(UIImage(named: "newTaskButton"), for: .normal)
        addButton.layer.shadowColor = UIColor(named: "addButtonShadowColor")?.cgColor
        addButton.layer.shadowOpacity = 0.3
        addButton.layer.shadowOffset = .zero
        addButton.layer.shadowRadius = 20
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -54).isActive = true
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showDoneToDos ? FileCache.instance.todos.count + 1 : FileCache.instance.activeTodos.count + 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: AddItemCell.identifier, for: indexPath) as! AddItemCell
            cell.onTextDidChange = { text in
                let task = ToDoItem(text: text, completed: false, importance: .default, createdAt: Date().timeIntervalSince1970.toInt() ?? 0)
                self.networkingService.createItem(task) { result in
                    switch result {
                    case .success(_):
                        print("success")
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            return cell
        }
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        
        cell.todo = showDoneToDos ? FileCache.instance.todos[indexPath.row] : FileCache.instance.activeTodos[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
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
    
    
    
    
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
