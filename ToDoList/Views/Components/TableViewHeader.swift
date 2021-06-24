//
//  TableViewHeader.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 19.06.2021.
//

import UIKit

class TableViewHeader: UIView {

    let doneLabel = UILabel()
    let showButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContent()
        configureDoneLabel()
        configureShowButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent() {
        doneLabel.translatesAutoresizingMaskIntoConstraints = false
        showButton.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(doneLabel)
        self.addSubview(showButton)
        
        // TODO: add constraints to label and button
        NSLayoutConstraint.activate([
            doneLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            doneLabel.trailingAnchor.constraint(greaterThanOrEqualTo: showButton.leadingAnchor, constant: 20),
            doneLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            showButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func configureDoneLabel() {
        doneLabel.textAlignment = .left
        doneLabel.text = "Всего — \(FileCache.instance.todos.count)"
        doneLabel.font = .systemFont(ofSize: 15)
        doneLabel.alpha = 0.3
    }
    
    func configureShowButton() {
        showButton.setTitle("Показать", for: .normal)
        showButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        showButton.setTitleColor(UIColor(named: "showButtonColor"), for: .normal)
    }
    
    @IBAction func showButtonDidTap(_ sender: UIButton) {
        FileCache.instance.activeTodos
    }
}
