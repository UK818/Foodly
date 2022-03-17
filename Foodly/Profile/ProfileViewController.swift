//  ProfileViewController.swift
//  Foodly
//  Created by Decagon on 12/06/2021.

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var profileNumberTextField: UITextField!
    @IBOutlet weak var profileNumberLabel: UILabel!
    @IBOutlet weak var profileName: UILabel!
    
    private let button: UIButton = {
        let button = UIButton()
        button.tintColor = foodlyPurple
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 0)
        return button
    }()
    
    let profileViewModel = ProfileViewModel()
    let cartViewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileNumberTextField.isHidden = true
        addressTextField.isHidden = true
        setNavBar()
        setupRightBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        profileViewModel.getProfileDetails()
        profileViewModel.notificationCompletion = {
            DispatchQueue.main.async {
                self.profileName.text = self.profileViewModel.fullName
                self.profileNumberLabel.text = self.profileViewModel.phoneNumber
                self.addressLabel.text = self.profileViewModel.userAddress
            }
        }
        
        cartViewModel.addressUpdateCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.profileName.text = self?.profileViewModel.fullName
                self?.profileNumberLabel.text = self?.profileViewModel.phoneNumber
                self?.addressLabel.text = self?.profileViewModel.userAddress
            }
        }
    }
    
    private func setupRightBarButton() {
        navigationItem.rightBarButtonItem = nil
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        button.setTitle("Edit", for: .normal)
    }
    
    @objc private func editButtonTapped() {
        button.title(for: .normal) == "Done" ? saveDetails() : editDetails()
    }
    
    private func saveDetails() {
        if profileNumberTextField.text != nil && profileNumberTextField.text?.isEmpty == false
            && addressTextField != nil
            && addressTextField.text?.isEmpty == false {
            HUD.show(status: "Updating...")
            profileNumberLabel.text = profileNumberTextField.text
            addressLabel.text = addressTextField.text
        } else {
            HUD.hide()
            self.showAlert(alertText: "Error",
                           alertMessage: "Please type in your address and phone number")
        }
        addressLabel.isHidden = false
        profileNumberLabel.isHidden = false
        addressTextField.isHidden = true
        profileNumberTextField.isHidden = true
        profileViewModel.updateProfile(view: self, profileViewModel.email, profileViewModel.fullName,
                                       addressLabel.text ??
                                        "Update your address", profileNumberLabel.text ?? "Update your phone number")
        button.setTitle("Edit", for: .normal)
    }
    
    private func editDetails() {
        addressTextField.text = addressLabel.text
        profileNumberTextField.text = profileNumberLabel.text
        addressLabel.isHidden = true
        profileNumberLabel.isHidden = true
        addressTextField.isHidden = false
        profileNumberTextField.isHidden = false
        button.setTitle("Done", for: .normal)
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "Are you sure you want to log out?",
                                            message: "",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { [weak self] _ in
            HUD.show(status: "Logging out...")
            do {
                try Auth.auth().signOut()
            } catch {
                self?.showAlert(alertText: "Error",
                               alertMessage: "There was an error logging you out. Please try again.")
            }
            HUD.hide()
            let newStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let controller = newStoryboard
                .instantiateViewController(identifier: "LoginViewController")
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            self?.present(controller, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
}
