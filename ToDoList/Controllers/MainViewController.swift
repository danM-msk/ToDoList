//
//  MainViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 18.06.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    public static let instance = MainViewController()
    
    var tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
    let addButton = UIButton()
    let titleLabel = UILabel()
    let doneLabel = UILabel()
    let showButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTitleLabel()
        configureDoneLabel()
        configureShowButton()
        configureTableView()
        configureAddButton()
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
        print("Tapped")
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
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
        let rootViewController = AddTaskViewController()
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        present(navigationViewController, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FileCache.instance.count + 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: AddItemCell.identifier, for: indexPath) as! AddItemCell
            return cell
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TaskCell
            let todo = FileCache.instance.todos[indexPath.row]
            
            if todo.deadline == nil {
                cell.dateLabel.isHidden = true
            } else {
                cell.dateLabel.isHidden = false
            }
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "calendar")
            let fullString = NSMutableAttributedString(attachment: imageAttachment)
            fullString.append(NSAttributedString(string: todo.deadline?.description ?? "No date"))
            cell.dateLabel?.attributedText = fullString
            
            if todo.isDone == true {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: todo.text)
                    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                cell.textLabel?.attributedText = attributeString
                cell.radioButton.setImage(UIImage(named: "radioButtonDone"), for: .normal)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                cell.taskLabel?.text = todo.text
                cell.radioButton.setImage(UIImage(named: "radioButtonDefault"), for: .normal)
            }
            return cell
        }
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
    
    
    
    
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
