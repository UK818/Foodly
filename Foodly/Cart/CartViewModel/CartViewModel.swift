//
//  CartViewModel.swift
//  Foodly
//
//  Created by Decagon on 15/06/2021.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseRemoteConfig

class CartViewModel {
    
    var mealsCart = Set<ItemsDetailModel>()
    var parsedDiscount = ""
    var restaurantId = ""
    var upDateDiscount: ((FinalCalculation) -> Void)?
    
    public let remoteConfig = RemoteConfig.remoteConfig()
    
    var initialAmountHandler: ((Float) -> Void)?
    var discount: Float = 0
    var tax: Float = 0.05
    var initialAmounts: Float = 0.00
    
    var itemNumber = 0
    var image = ""
    var restName = ""
    
    var totalAmount = [Float]()
    var name = ""
    
    var names = [String]()
    var phones = [String]()
    var notificationCompletion: (() -> Void)?
    var addressUpdateCompletion: (() -> Void)?
    var address = ""
    
    var mealsCartArray = [ItemsDetailModel]()
    
    func getAddress() {
        let docId = Auth.auth().currentUser?.uid
        let docRef = Firestore.firestore().collection("/users").document("\(docId!)")
        docRef.getDocument {(document, _) in
            if let document = document, document.exists {
                let docData = document.data()
                let address = docData!["address"] as? String ?? "Edit address"
                self.address.append(address)
            }
            self.notificationCompletion?()
            
        }
    }
    
    func updateAddress(view: UIViewController, _ address: String) {
        self.address = ""
        let docId = Auth.auth().currentUser?.uid
        let docRef = Firestore.firestore().collection("/users").document("\(docId!)")
        docRef.updateData(["address": address]) {(error) in
            if error != nil {
                HUD.hide()
                AlertController.showAlert(view,
                                          title: "Error",
                                          message: "There was an updating your address. Please try again.")
            } else {
                self.address.append(address)
                HUD.hide()
                AlertController.showAlert(view, title: "Done", message: "Address updated successfully!")
            }
            self.addressUpdateCompletion?()
        }
    }
    func getMeal() {
        for meals in mealsCart {
            mealsCartArray.append(meals)
        }
    }
    
    func fetchValues(insertedCode: String, completion: @escaping (String, String) -> Void) {
        
        let service = RemoteConfigService()
        service.fetchValues(insertedCode: insertedCode) { [self] result in
            switch result {
                
            case .success(let successful):
                completion(successful, """
"You have been given a discount of \(self.parsedDiscount)% on the entire items bought
""")
                self.discount = Float(parsedDiscount) ?? 0.00
                calculateTotal(discount: discount) { updateValues in
                    upDateDiscount?(updateValues)
                }
                
            case .failure(let failed):
                completion("Invalid Promo Code", failed.localizedDescription)
            }
        }
        
    }
    
    func calculateTotal(discount: Float, completion: (FinalCalculation) -> Void) {
        let initialTotal = mealsCartArray.reduce(Float(0.0)) { result, cartModel -> Float in
            if let initialAmonts = Float(cartModel.foodAmount) {
                let foodQty = Float(cartModel.foodQuantity)
                let tempAmount = Float(result) + ( initialAmonts * foodQty)
                return tempAmount
            }
            return 0.00
        }
        let discountAmount = (discount * initialTotal)/10000
        let taxAmount = (tax * initialTotal/100)
        
        let amount = "$" + String(format: "%.2f", initialTotal/100)
        let finalTotal = "$" + String(format: "%.2f",
                                      initialTotal/100 - discountAmount + taxAmount)
        let discount = "$" + String(format: "%.2f", discountAmount)
        let taxPayable = "$" + (String(format: "%.2f", taxAmount))
        
        let runCalc = FinalCalculation(itemAmout: amount,
                                       itemDiscount: discount,
                                       fixedtax: taxPayable,
                                       cartTotal: finalTotal)
        completion(runCalc)
    }
    
    struct FinalCalculation {
        let itemAmout: String
        let itemDiscount: String
        let fixedtax: String
        let cartTotal: String
    }
}
