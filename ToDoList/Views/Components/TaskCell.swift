//
//  TaskCell.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 18.06.2021.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func radioButtonDidTap(_ sender: Any) {
        
        radioButton.setImage(UIImage(named: "radioButtonDone"), for: .normal)
//        TODO: configure radioButton
    }
    
}
