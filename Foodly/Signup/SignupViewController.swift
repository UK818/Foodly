//
//  SignupViewController.swift
//  Foodly
//
//  Created by Usman on 30/05/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupViewController: UIViewController {
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var secureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func validateTextField() {
        if !fullName.text!.hasWhiteSpace {
            self.showAlert(alertText: "Oops", alertMessage: "Please, enter your firstname and lastname")
        }
        
        if fullName.text == "" {
            self.showAlert(alertText: "Oops", alertMessage: "Please, enter your full name")
        }
        
        if emailField.text == "" {
            self.showAlert(alertText: "Oops", alertMessage: "Please, enter your email")
        }
        
        if emailField.text != "" && emailField.text!.isValidEmail == false {
            self.showAlert(alertText: "Invalid Email", alertMessage: "Please, enter a valid email")
        }
        
        if passField.text == "" {
            self.showAlert(alertText: "Oops", alertMessage: "Please enter your password")
        }
        
        if passField.text != "" && passField.text!.isValidPassword == false {
            self.showAlert(alertText: "Oops",
                           alertMessage: "Password must be alphanumeric and must be greater than 8 characters")
        }
    }
    
    @IBAction func securePassword(_ sender: Any) {
        passField.isSecureTextEntry.toggle()
        let imageName = passField.isSecureTextEntry ? "eye" : "eye.slash"
        secureButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func getStarted(_ sender: Any) {
        validateTextField()
        HUD.show(status: "Just a second...")
        if let email = emailField.text, let password = passField.text, let fullName = fullName.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error, authResult != nil {
                    print(error.localizedDescription)
                    HUD.hide()
                } else {
                    let docId = Auth.auth().currentUser?.uid
                    Firestore.firestore().collection("users").document(docId!).setData(
                        ["email": email, "fullName": fullName,
                         "address": "Update your address", "phoneNumber": "Update Phone Number"]) { (error) in
                        if error != nil {
                            HUD.hide()
                            self.showAlert(alertText: "Error",
                                           alertMessage: "There was an error creating account, please try again.")
                        } else {
                            HUD.hide()
                            let alertController =
                            UIAlertController(title: "Done",
                                              message: "Account created successfully!", preferredStyle: .alert)
                            let acceptAction = UIAlertAction(title: "Accept", style: .default) { (_) -> Void in
                                self.navigateToHome()
                            }
                            alertController.addAction(acceptAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
