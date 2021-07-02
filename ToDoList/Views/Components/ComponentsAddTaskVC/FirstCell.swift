//
//  FirstCell.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 02.07.2021.
//

import UIKit

class FirstCell: UITableViewCell {
    
    static let identifier = "FirstCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "FirstCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
