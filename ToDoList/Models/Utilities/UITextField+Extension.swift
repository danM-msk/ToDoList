//
//  UITextFieldExtension.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 03.07.2021.
//

import UIKit

class UITextFieldExtension: UITextField {

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
