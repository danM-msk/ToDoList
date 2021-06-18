//
//  MainViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 18.06.2021.
//

import UIKit

class MainViewController: UIViewController {


    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTitle()
        configureDoneLabel()
        configureShowButton()
        configureTableView()
        configureAddButton()
    }
    
    func configureTitle() {
        title = "Мои дела"
        navigationController?.navigationBar.layoutMargins.left = 32
    }
    
    func configureDoneLabel() {
        doneLabel.textAlignment = .left
        doneLabel.text = "Выполнено — ЧИСЛО СЮДЫ"
        doneLabel.font = .systemFont(ofSize: 15)
        doneLabel.alpha = 0.3
    }
    
    func configureShowButton() {
        showButton.setTitle("Показать", for: .normal)
        showButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        showButton.setTitleColor(UIColor(named: "showButtonColor"), for: .normal)
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 16
    }
    
    func configureAddButton() {
        addButton.layer.shadowColor = UIColor(named: "addButtonShadowColor")?.cgColor
        addButton.layer.shadowOpacity = 0.3
        addButton.layer.shadowOffset = .zero
        addButton.layer.shadowRadius = 20
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TaskCell
        cell.dateLabel?.text = "Date"
        cell.taskLabel?.text = "task"
        return cell
    }
    
    
}
