//
//  OrderConfirmationViewModel.swift
//  Foodly
//
//  Created by Decagon on 6/24/21.
//

import Foundation

class OrderConfirmationViewModel {
    var deliveryDetail = [DeliveryDetails]()
    var restairantId = ""
    var notifyCompletion: (() -> Void)?
    
    func deliver(restaurantId: String) {
        let getOrder = DeliveryPersonService()
        getOrder.getDeliveryPersonDetails(restaurantID: restaurantId) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let result):
                result?.documents.forEach({ (doc) in
                    let data = doc.data()
                    if let image = data["image"] as? String, let name = data["name"] as? String,
                       let phone = data["phone"] as? String,
                       let delivery = data["delivery"] as? String {
                        if let delivert = Int(delivery) {
                            let details = DeliveryDetails(phones: phone,
                                                          names: name, images: image,
                                                          delivery: delivert/60,
                                                          preparationTime: Double(delivert - 120),
                                                          deliveryTime: Double(delivert))
                            self.deliveryDetail.append(details)
                        }
                    }
                })
                self.notifyCompletion?()
            }
        }
    }
}
