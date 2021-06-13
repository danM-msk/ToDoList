//
//  ViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 04.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var createTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconImage.layer.cornerRadius = 8.0
        createTaskButton.layer.cornerRadius = 8.0
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        if let unwrapped = appVersion {
            _ = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            let appVersionText = "ToDoList version ".localized()
            textLabel.text = appVersionText + unwrapped
        } else {
            textLabel.text = "Build number is unavailable"
        }

        iconImage.image = UIImage(named: "AppIcon")
    }

}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
