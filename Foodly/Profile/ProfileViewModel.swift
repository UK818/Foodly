//
//  ProfileViewModel.swift
//  Foodly
//
//  Created by Decagon on 29/06/2021.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit

struct ProfileModel {
    var address = ""
    var phoneNumber = ""
}

extension ProfileModel: RequestParameter {
    
    var asParameter: Parameter {
        return ["address": address, "phoneNumber": phoneNumber]
    }
}

class ProfileViewModel {
    var fullName = ""
    var userAddress = ""
    var phoneNumber = ""
    var email = ""
    var notificationCompletion: (() -> Void)?
    
    func getProfileDetails() {
        self.userAddress = ""
        self.phoneNumber = ""
        self.fullName = ""
        let docId = Auth.auth().currentUser?.uid
        let docRef = Firestore.firestore().collection("/users").document("\(docId!)")
        docRef.getDocument {(document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let userEmail = docData!["email"] as? String ?? "Email???"
                let userFullName = docData!["fullName"] as? String ?? "Full name???"
                let address = docData!["address"] as? String ?? "Edit address"
                let phoneNumber = docData!["phoneNumber"] as? String ?? "Add Phone Number"
                self.userAddress.append(address)
                self.phoneNumber.append(phoneNumber)
                self.email.append(userEmail)
                self.fullName.append(userFullName)
            } else {
                print( error?.localizedDescription as Any )
            }
            self.notificationCompletion?()
        }
    }
    
    func updateProfile(view: UIViewController,
                       _ email: String, _ fullName: String, _ address: String, _ phoneNumber: String) {
        
        let docId = Auth.auth().currentUser?.uid
        Firestore.firestore().collection("users").document(docId!).setData(
            ["email": email, "fullName": fullName, "address": address, "phoneNumber": phoneNumber]) { (error) in
            if error != nil {
                HUD.hide()
                AlertController.showAlert(view,
                                          title: "Error",
                                          message: "There was an error saving your profile. Please try again.")
            } else {
                HUD.hide()
                AlertController.showAlert(view, title: "Done", message: "Profile updated successfully!")
                
            }
        }
    }
    
}
