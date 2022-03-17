//
//  LoginViewController.swift
//  Foodly
//
//  Created by Usman on 30/05/2021.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    private let viewModel = LoginViewModel()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var hidePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        emailTextField.becomeFirstResponder()
        
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let pass = passwordTextField.text,
           !email.isEmpty, !pass.isEmpty {
            HUD.show(status: "Signing you in...")
            viewModel.loginUser(with: email, password: pass) { [weak self] success in
                HUD.hide()
                success ? self?.navigateToHome() : self?
                    .showAlert(alertText: "Incorrect Details",
                               alertMessage: "Incorrect email or password. Please check your details and try again.")
            }
        } else {
            HUD.hide()
            self.showAlert(alertText: "Incomplete details", alertMessage: "Please, enter your email and password.")
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        navigateToRegistrationScreen()
    }
    
    @IBAction func hidePasswordBtnTapped(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        hidePasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func navigateToRegistrationScreen() {
        let newStoryboard = UIStoryboard(name: "Signup", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "signup") as SignupViewController
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true, completion: nil)
    }
}
