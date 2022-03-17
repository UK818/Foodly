//
//  ClientService.swift
//  Foodly
//
//  Created by Decagon on 6/8/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class Client {
    private init() {}
    static let shared = Client()
    
    func createUser<T: Encodable>(for encodableObject: T,
                                  in collectionReference: ClientCollectionReference,
                                  withEmail: String, password: String, inViewController: UIViewController) {
        do {
            let json = try encodableObject.toJson(excluding: ["id"])
            Auth.auth().createUser(withEmail: withEmail, password: password) { [self] (_, err) in
                if err != nil {
                    AlertController.showAlert(inViewController, title: "Error", message: "Error Creating User" )
                } else {
                    AlertController.showAlert(inViewController, title: "Success", message: "SignUp Sucessful")
                    Firestore.firestore().collection(collectionReference.rawValue).addDocument(data: json) { (error) in
                        
                        if error != nil {
                            AlertController.showAlert(inViewController, title: "Error", message: "Error saving data" )
                        }
                    }}
            }} catch {
                AlertController.showAlert(inViewController, title: "Error", message: error.localizedDescription )
            }
    }
    
    func userLogin (withEmail: String, password: String, inViewController: UIViewController) {
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: { (_, error) in
            if error != nil {
                AlertController.showAlert(inViewController, title: "Error",
                                          message: "incorrect email or password")
                return
            } else {
                AlertController.showAlert(inViewController, title: "Success", message: "Login Sucessful")
            }
        })
    }
    
    func userLogout(inViewController: UIViewController) {
        do {
            try Auth.auth().signOut()
        } catch {
            AlertController.showAlert(inViewController, title: "Error", message: error.localizedDescription )
        }
    }
    
}
