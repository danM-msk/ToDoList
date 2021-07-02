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
    
    var prioritySegmentedControl = UISegmentedControl()
    var datePicker = UIDatePicker()
    var optionsStack = UIStackView()
    var prioritySwitch = UISwitch()
    var separator2 = UIView()
    var deleteButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        configureNavigationBar()
        configureScrollView()
        configureTextField()
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
    
    func configureOptions() {
        optionsStack.layer.cornerRadius = 16.0
        datePicker.isHidden = true
        prioritySwitch.isOn = false
        separator2.isHidden = true
    }
    
    func configureDeleteButton() {
        deleteButton.layer.cornerRadius = 16.0
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
