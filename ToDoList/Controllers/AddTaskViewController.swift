//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 13.06.2021.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var toDoItem: ToDoItem? = nil
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var optionsStack: UIStackView!
    @IBOutlet weak var prioritySwitch: UISwitch!
    @IBOutlet weak var separator2: UIView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTitle()
        configureTextField()
        configureOptions()
        configureDeleteButton()
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
    
    func configureTitle() {
        title = "Дело"
    }
    
    func configureTextField() {
        textField.layer.cornerRadius = 16
        textField.delegate = self
    }
    
    func goBack() {
        let vc = AddTaskViewController()
        vc.dismiss(animated: true, completion: nil)
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
    
    func saveTask() {
        priorityOptions()
        let item = ToDoItem(text: textField.text ?? "Без заголовка", priority: priority, deadline: datePicker.date, isDone: false)
        FileCache.instance.addToDo(item)
    }
    
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        goBack()
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        saveTask()
        print(FileCache.instance.todos.description)
        goBack()
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        goBack()
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
