//
//  OrderService.swift
//  Foodly
//
//  Created by Decagon on 6/8/21.
//

import Foundation

struct OrderService {
    let router = Router<OrderApi>()
    
    func createOrder(with food: Food, completion: @escaping NetworkRouterCompletion) {
        router.request(.createFoodOrder(items: food), completion: completion)
    }
    
    func getFoodHistory(completion: @escaping NetworkRouterCompletion) {
        router.request(.getFoodHistory, completion: completion)
    }
    func updateFoodHistory(userId: String, with food: Food, completion: @escaping NetworkRouterCompletion) {
        router.request(.updateFoodHistory(foodID: userId, items: food), completion: completion)
    }
    
}
