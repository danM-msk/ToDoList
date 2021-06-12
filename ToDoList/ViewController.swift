//
//  ViewController.swift
//  ToDoList
//
//  Created by Daniyar Mamadov on 04.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        if let unwrapped = appVersion {
            _ = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            let appVersionText = "ToDoList version ".localized()
            textLabel.text = appVersionText + unwrapped
        } else {
            textLabel.text = "Build number is unavailable"
        }

        iconView.image = UIImage(named: "AppIcon")
    }

}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
