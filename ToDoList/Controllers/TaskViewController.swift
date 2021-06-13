//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 13.06.2021.
//

import UIKit

class TaskViewController: UIViewController {
    
    var toDoItem: ToDoItem? = nil
    
    let fileCache = FileCache.instance

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var optionsStackView: UIStackView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var prioritySwitch: UISwitch!
    @IBOutlet weak var separator2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.layer.cornerRadius = 16.0
        optionsStackView.layer.cornerRadius = 16.0
        deleteButton.layer.cornerRadius = 16.0
        datePicker.isHidden = true
        prioritySwitch.isOn = false
        separator2.isHidden = true
    }
    
    var priority: ToDoItemPriority = .Default
    
    func priorityOptions() {
        switch prioritySegmentedControl.selectedSegmentIndex {
                case 0:
                    priority = .Unimportant
                case 1:
                    priority = .Default
                case 2:
                    priority = .Important
                default:
                    priority = .Default
                }
    }
    
    func saveOptions() {
        priorityOptions()
        let item = ToDoItem(text: textField.text ?? "Без заголовка", priority: priority, deadline: datePicker.date)
        fileCache.addToDo(item)
        
    }
    
    @IBAction func saveButtonDidTap(_ sender: UIButton) {
        saveOptions()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
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
