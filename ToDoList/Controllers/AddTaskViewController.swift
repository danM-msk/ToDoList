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
    @IBOutlet weak var optionsStackView: UIStackView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var prioritySwitch: UISwitch!
    @IBOutlet weak var separator2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureTextField()
        configureOptions()
        configureDeleteButton()
    }
    
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
        textField.layer.cornerRadius = 16.0
        textField.delegate = self
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddTaskViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
        view.endEditing(true)
    }
    
    @objc func handleTap() {
        
    }
    
    func configureOptions() {
        optionsStackView.layer.cornerRadius = 16.0
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        saveTask()
        self.dismiss(animated: true, completion: nil)
        print(FileCache.instance.todos.description)
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
