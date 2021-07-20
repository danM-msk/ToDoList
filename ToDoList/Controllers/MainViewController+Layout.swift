//
//  MainViewController+Layout.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 20.07.2021.
//

import Foundation
import UIKit

extension MainViewController {
    
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
}
