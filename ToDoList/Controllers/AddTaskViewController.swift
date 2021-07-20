//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 13.06.2021.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    let networkingService = DefaultNetworkingService.instance
    
    public var completion: (() -> ())?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.insetsLayoutMarginsFromSafeArea = true
        scrollView.contentInsetAdjustmentBehavior = .always
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    var textField = UITextFieldExtension()
    let optionsStackView = UIStackView()
    let importanceView = UIView()
    let importanceLabel = UILabel()
    let importanceSegmentedControl = UISegmentedControl(items: ["↓", "нет", "!!"])
    let dateView = UIView()
    let dateLabel = UILabel()
    let dateSwitch = UISwitch()
    let datePicker = UIDatePicker()
    let deleteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        configureTextField()
        configureOptionsStackView()
        configureImportanceView()
        configureImportanceSegmentedControl()
        configureImportanceLabel()
        configureDateView()
        configureDateSwitch()
        configureDateLabel()
        configureDatePicker()
        configureDeleteButton()
    }
    
    @objc func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonDidTap() {
        saveTask()
        dismiss(animated: true, completion: completion)
        print(FileCache.instance.cache)
    }
    
    @objc func deleteButtonDidTap () {
        //TODO: delete ToDoItem from FileCache
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dateSwitchDidTap() {
        if dateSwitch.isOn == true {
            datePicker.isHidden = false
        } else {
            datePicker.isHidden = true
        }
    }
    
    func importanceStateFromSegmentedControl() -> Importance {
        switch importanceSegmentedControl.selectedSegmentIndex {
        case 0:
            return .unimportant
        case 1:
            return .default
        case 2:
            return .important
        default:
            return .default
        }
    }
    
    func saveTask() {
        guard let content = textField.text, content.count > 0 else { return } // TODO: inplement UIAlertView
        let item = ToDoItem(text: content, completed: false, importance: importanceStateFromSegmentedControl(), deadline: datePicker.date)
        FileCache.instance.addToDo(item)
        networkingService.createItem(item) { result in
            switch result {
            case .success(_):
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
