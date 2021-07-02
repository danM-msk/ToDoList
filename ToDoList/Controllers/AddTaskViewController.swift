//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 13.06.2021.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let mainView = UIScrollView()
        mainView.insetsLayoutMarginsFromSafeArea = true
        mainView.contentInsetAdjustmentBehavior = .always
        mainView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        mainView.backgroundColor = .clear
        return mainView
    }()
    
    var textField = TextFieldExtension()
    let optionsStackView = UIStackView()
    let importanceView = UIView()
    let importanceLabel = UILabel()
    let importanceSegmentedControl = UISegmentedControl(items: ["↓", "нет", "!!"])
    let separator1 = UIView()
    let dateView = UIView()
    
    let deleteButton = UIButton()
    
    
    var datePicker = UIDatePicker()
    var prioritySwitch = UISwitch()
    var separator2 = UIView()
    
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
        configureSeparator1()
        configureDateView()
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
//        priorityOptions()
        let item = ToDoItem(text: "Без заголовка", priority: priority, deadline: datePicker.date, isDone: false)
        FileCache.instance.addToDo(item)
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
        textField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 120).isActive = true
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
    
    func configureOptionsStackView() {
        scrollView.addSubview(optionsStackView)
        optionsStackView.backgroundColor = .white
        optionsStackView.layer.cornerRadius = 16.0
        optionsStackView.axis = .vertical
        setOptionsStackViewConstraints()
        
    }
        
    func setOptionsStackViewConstraints() {
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        optionsStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16).isActive = true
        optionsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        optionsStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
    }
    
    func configureImportanceView() {
        optionsStackView.addArrangedSubview(importanceView)
        importanceView.backgroundColor = .clear
        setImportanceViewConstraints()
    }

    func setImportanceViewConstraints() {
        importanceView.translatesAutoresizingMaskIntoConstraints = false
        importanceView.topAnchor.constraint(equalTo: optionsStackView.topAnchor).isActive = true
        importanceView.centerYAnchor.constraint(equalTo: optionsStackView.centerYAnchor).isActive = true
        importanceView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        importanceView.widthAnchor.constraint(equalToConstant: optionsStackView.frame.width).isActive = true
    }

    
    func configureImportanceLabel() {
        importanceView.addSubview(importanceLabel)
        importanceLabel.text = "Важность"
        importanceLabel.textAlignment = .left
        importanceLabel.font = UIFont.systemFont(ofSize: 17)
        setImportanceLabelConstraints()
    }
    
    func setImportanceLabelConstraints() {
        importanceLabel.translatesAutoresizingMaskIntoConstraints = false
        importanceLabel.centerYAnchor.constraint(equalTo: importanceView.centerYAnchor).isActive = true
        importanceLabel.leftAnchor.constraint(equalTo: importanceView.leftAnchor, constant: 16).isActive = true
        importanceLabel.rightAnchor.constraint(equalTo: importanceSegmentedControl.leftAnchor).isActive = true
    }
    
    func configureImportanceSegmentedControl() {
        importanceView.addSubview(importanceSegmentedControl)
        setImportanceSegmentedControlConstraints()
    }
    
    func setImportanceSegmentedControlConstraints() {
        importanceSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        importanceSegmentedControl.centerYAnchor.constraint(equalTo: importanceView.centerYAnchor).isActive = true
        importanceSegmentedControl.trailingAnchor.constraint(equalTo: importanceView.trailingAnchor, constant: -12).isActive = true
//        importanceSegmentedControl.leadingAnchor.constraint(equalTo: importanceLabel.trailingAnchor).isActive = true
    }
    
    func configureSeparator1() {
        importanceView.addSubview(separator1)
        separator1.translatesAutoresizingMaskIntoConstraints = false
        separator1.leadingAnchor.constraint(equalTo: importanceView.leadingAnchor, constant: 16).isActive = true
        separator1.trailingAnchor.constraint(equalTo: importanceView.trailingAnchor).isActive = true
        separator1.topAnchor.constraint(equalTo: importanceLabel.bottomAnchor, constant: 1).isActive = true
        separator1.bottomAnchor.constraint(equalTo: importanceView.bottomAnchor).isActive = true
    }
    
    func configureDateView() {
        optionsStackView.addArrangedSubview(dateView)
        dateView.backgroundColor = .clear
        setDateViewConstraints()
    }
    
    func setDateViewConstraints() {
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.topAnchor.constraint(equalTo: optionsStackView.topAnchor).isActive = true
        dateView.centerYAnchor.constraint(equalTo: optionsStackView.centerYAnchor).isActive = true
        dateView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        dateView.widthAnchor.constraint(equalToConstant: optionsStackView.frame.width).isActive = true
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
        deleteButton.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 16).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    @objc func deleteButtonDidTap () {
        //TODO: delete ToDoItem from FileCache
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
//    func configureOptions() {
//        optionsStack.layer.cornerRadius = 16.0
//        datePicker.isHidden = true
//        prioritySwitch.isOn = false
//        separator2.isHidden = true
//    }
    
    var textOutput: String?
    var priority: ToDoItemPriority = .normal
    
//    func priorityOptions() {
//        switch prioritySegmentedControl.selectedSegmentIndex {
//        case 0:
//            priority = .unimportant
//        case 1:
//            priority = .normal
//        case 2:
//            priority = .important
//        default:
//            priority = .normal
//        }
//    }
    
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
