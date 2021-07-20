//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 13.06.2021.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    let networkingService = DefaultNetworkingService.instance
    
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
    
    public var completion: (() -> ())?
    
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
        dismiss(animated: true, completion: completion)
        print(FileCache.instance.cache)
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
    
    func configureTextField() {
        scrollView.addSubview(textField)
        textField.backgroundColor = .white
        textField.placeholder = "Что надо сделать?"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.layer.cornerRadius = 16
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 16).isActive = true
        textField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func configureOptionsStackView() {
        scrollView.addSubview(optionsStackView)
        optionsStackView.backgroundColor = .white
        optionsStackView.layer.cornerRadius = 16.0
        optionsStackView.axis = .vertical
        optionsStackView.distribution = .fillProportionally
        optionsStackView.spacing = 2.5
        
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        optionsStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16).isActive = true
        optionsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        optionsStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        
        optionsStackView.addArrangedSubview(importanceView)
        optionsStackView.addArrangedSubview(dateView)
        optionsStackView.addArrangedSubview(datePicker)
    }
    
    func configureImportanceView() {
        importanceView.backgroundColor = .clear
        
        importanceView.translatesAutoresizingMaskIntoConstraints = false
        importanceView.topAnchor.constraint(equalTo: optionsStackView.topAnchor).isActive = true
        importanceView.centerXAnchor.constraint(equalTo: optionsStackView.centerXAnchor).isActive = true
        importanceView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        importanceView.widthAnchor.constraint(equalToConstant: optionsStackView.frame.width).isActive = true
    }
    
    func configureImportanceLabel() {
        importanceView.addSubview(importanceLabel)
        importanceLabel.text = "Важность"
        importanceLabel.textAlignment = .left
        importanceLabel.font = UIFont.systemFont(ofSize: 17)
        
        importanceLabel.translatesAutoresizingMaskIntoConstraints = false
        importanceLabel.centerYAnchor.constraint(equalTo: importanceView.centerYAnchor).isActive = true
        importanceLabel.leftAnchor.constraint(equalTo: importanceView.leftAnchor, constant: 16).isActive = true
        importanceLabel.trailingAnchor.constraint(equalTo: importanceSegmentedControl.leadingAnchor).isActive = true
    }
    
    func configureImportanceSegmentedControl() {
        importanceView.addSubview(importanceSegmentedControl)
        importanceSegmentedControl.setEnabled(true, forSegmentAt: 1)
        
        importanceSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        importanceSegmentedControl.centerYAnchor.constraint(equalTo: importanceView.centerYAnchor).isActive = true
        importanceSegmentedControl.trailingAnchor.constraint(equalTo: importanceView.trailingAnchor, constant: -12).isActive = true
    }
    
    func configureDateView() {
        dateView.backgroundColor = .clear
        
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.topAnchor.constraint(equalTo: importanceView.bottomAnchor).isActive = true
        dateView.centerXAnchor.constraint(equalTo: optionsStackView.centerXAnchor).isActive = true
        dateView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        dateView.widthAnchor.constraint(equalToConstant: optionsStackView.frame.width).isActive = true
    }
    
    func configureDateLabel(){
        dateView.addSubview(dateLabel)
        dateLabel.text = "Сделать до"
        dateLabel.textAlignment = .left
        dateLabel.font = UIFont.systemFont(ofSize: 17)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerYAnchor.constraint(equalTo: dateView.centerYAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: dateView.leftAnchor, constant: 16).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: dateSwitch.leftAnchor).isActive = true
    }
    
    func configureDateSwitch() {
        dateView.addSubview(dateSwitch)
        dateSwitch.isOn = false
        dateSwitch.addTarget(self, action: #selector(dateSwitchDidTap), for: .touchUpInside)
        
        dateSwitch.translatesAutoresizingMaskIntoConstraints = false
        dateSwitch.centerYAnchor.constraint(equalTo: dateView.centerYAnchor).isActive = true
        dateSwitch.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -12).isActive = true
    }
    
    @objc func dateSwitchDidTap() {
        if dateSwitch.isOn == true {
            datePicker.isHidden = false
        } else {
            datePicker.isHidden = true
        }
    }
    
    func configureDatePicker(){
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.calendar = .current
        if dateSwitch.isOn == false {
            datePicker.isHidden = true
        } else {
            datePicker.isHidden = false
        }
        
        datePicker.heightAnchor.constraint(equalToConstant: datePicker.frame.height).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: datePicker.frame.width).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: optionsStackView.centerXAnchor).isActive = true
    }
    
    func configureDeleteButton() {
        scrollView.addSubview(deleteButton)
        deleteButton.backgroundColor = .white
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.layer.cornerRadius = 16.0
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 16).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    @objc func deleteButtonDidTap () {
        //TODO: delete ToDoItem from FileCache
        dismiss(animated: true, completion: nil)
    }
    
    //    var textOutput: String?
}

extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
