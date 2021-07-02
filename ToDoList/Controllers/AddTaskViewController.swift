//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 13.06.2021.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    let scrollView = UIScrollView()
    var textField = TextFieldExtension()
    var tableView = UITableView()
    let deleteButton = UIButton()
    
    var prioritySegmentedControl = UISegmentedControl()
    var datePicker = UIDatePicker()
    var optionsStack = UIStackView()
    var prioritySwitch = UISwitch()
    var separator2 = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        configureNavigationBar()
        configureScrollView()
        configureTextField()
        configureTableView()
        
        
        configureOptions()
        configureDeleteButton()
    }
    
    func configureView() {
        view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    func configureNavigationBar() {
        title = "Создать дело"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancelButtonDidTap))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveButtonDidTap))
    }
    
    @objc func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonDidTap() {
        saveTask()
        print(FileCache.instance.todos.description)
        dismiss(animated: true, completion: nil)
    }
    
    func saveTask() {
        priorityOptions()
        let item = ToDoItem(text: "Без заголовка", priority: priority, deadline: datePicker.date, isDone: false)
        FileCache.instance.addToDo(item)
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor(named: "backgroundColor")
        scrollView.pin(to: view)
    }
    
    func configureTextField() {
        scrollView.addSubview(textField)
        textField.backgroundColor = .white
        textField.placeholder = "Что надо сделать?"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.layer.cornerRadius = 16
        textField.delegate = self
        setTextFieldConstraints()
    }
    
    func setTextFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 16).isActive = true
        textField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -16).isActive = true
    }
    
    class TextFieldExtension: UITextField {

        let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    }
    
    func configureTableView() {
        scrollView.addSubview(tableView)
        setTableViewDelegates()
        setTableViewConstraints()
        tableView.layer.cornerRadius = 16
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 56.0
        tableView.register(FirstCell.self, forCellReuseIdentifier: FirstCell.identifier)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: 16).isActive = true
        tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true
    }
    
    func configureDeleteButton() {
        scrollView.addSubview(deleteButton)
        setDeleteButtonConstraints()
        deleteButton.backgroundColor = .white
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.layer.cornerRadius = 16.0
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
    }
    
    func setDeleteButtonConstraints() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.heightAnchor
        deleteButton.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 160).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true
    }
    
    @objc func deleteButtonDidTap () {
        //TODO: delete ToDoItem from FileCache
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func configureOptions() {
        optionsStack.layer.cornerRadius = 16.0
        datePicker.isHidden = true
        prioritySwitch.isOn = false
        separator2.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var textOutput: String?
    var priority: ToDoItemPriority = .normal
    
    func priorityOptions() {
        switch prioritySegmentedControl.selectedSegmentIndex {
        case 0:
            priority = .unimportant
        case 1:
            priority = .normal
        case 2:
            priority = .important
        default:
            priority = .normal
        }
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        if sender.isOn {
            separator2.isHidden = false
            datePicker.isHidden = false
        } else {
            datePicker.isHidden = true
            separator2.isHidden = true
        }
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddTaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: FirstCell.identifier, for: indexPath) as! FirstCell
        return cell
//        if indexPath.row == 0 {
//            let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FirstCell
//            return cell
//        } else if indexPath.row == 1 {
//            let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SecondCell
//            return cell
//        }
    }
    
    
}
