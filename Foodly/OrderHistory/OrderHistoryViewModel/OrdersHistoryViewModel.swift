//
//  OrdersHistoryViewModel.swift
//  Foodly
//
//  Created by Decagon on 6/23/21.
//

import UIKit

class OrderHistoryViewModel {
    var orderHistoryArray = [OrderHistoryModel]()
    var notifyCompletion: (() -> Void)?
    
    func get() {
        self.orderHistoryArray.removeAll()
        let getHistory = OrderService()
        getHistory.getFoodHistory {(result) in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let result):
                result?.documents.forEach({ (doc) in
                    let data = doc.data()
                    if let image = data["image"] as? String, let food = data["food"] as? String,
                       let item = data["items"] as? String, let delivery = data["price"] as? String {
                        let order = OrderHistoryModel(restaurantName: food, totalPrice: delivery,
                                                      restaurantImage: image, itemQuantity: item)
                        self.orderHistoryArray.append(order)
                        print(order)
                    }
                })
                self.notifyCompletion?()
            }
        }
    }
}
