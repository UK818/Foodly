//
//  ViewController + Extension.swift
//  Foodly
//
//  Created by omokagbo on 01/06/2021.
//

import UIKit

extension UIViewController {
    
    func showAlert (alertText: String, alertMessage: String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationItem.backButtonTitle = " "
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    func navigateToHome() {
        let newStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = newStoryboard
            .instantiateViewController(identifier: "HomeTabBarNav") as UITabBarController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
}
