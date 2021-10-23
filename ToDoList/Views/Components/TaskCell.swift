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
    
    static let identifier: String = "TaskCell"
    static let cellNibName: String = "TaskCell"


    
    var todo: ToDoItem! {
        didSet {
            self.setupCell()
        }
    }
    
    @IBAction func radioButtonDidTap(_ sender: Any) {
//        todo.completed.toggle()
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: todo.text)
        let range = NSMakeRange(0, attributeString.length)
        
        if todo.completed {
            attributeString.addAttribute(.strikethroughStyle, value: 1, range: range)
            radioButton.setImage(UIImage(named: "radioButtonDone"), for: .normal)
        } else {
            attributeString.setAttributes([:], range: range)
            radioButton.setImage(UIImage(named: "radioButtonDefault"), for: .normal)
        }
        taskLabel.attributedText = attributeString

    }
    
    func setupCell() {
        dateLabel.isHidden = todo.deadline == nil ? true : false
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "calendar")
        let fullString = NSMutableAttributedString(attachment: imageAttachment)
        fullString.append(NSAttributedString(string: todo.deadline?.description ?? "No date"))
        dateLabel.attributedText = fullString
        
        if todo.completed {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: todo.text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            taskLabel.attributedText = attributeString
            radioButton.setImage(UIImage(named: "radioButtonDone"), for: .normal)
        } else {
            taskLabel.text = todo.text
            radioButton.setImage(UIImage(named: "radioButtonDefault"), for: .normal)
        }
        
        if todo.importance == .important {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "exclamationmark.2")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            let fullString = NSMutableAttributedString(attachment: imageAttachment)
            fullString.append(NSAttributedString(string: " \(todo.text)"))
            taskLabel.attributedText = fullString
            radioButton.setImage(UIImage(named: "radioButtonImportant"), for: .normal)
        }
        else { return }
    }
    
}
