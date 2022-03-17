//
//  Alert + Extension.swift
//  Foodly
//
//  Created by Decagon on 6/1/21.
//

import UIKit

class AlertController {
    static func showAlert(_ inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
}
