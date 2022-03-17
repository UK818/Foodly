//
//  DeliveryPersonService.swift
//  Foodly
//
//  Created by Decagon on 6/23/21.
//

import Foundation

struct DeliveryPersonService {
    let router = Router<DeliveryPersonApi>()
    
    func getDeliveryPersonDetails(restaurantID: String, completion: @escaping NetworkRouterCompletion) {
        router.request(.getDeliveryPersonDetails(restaurantID: restaurantID), completion: completion)
    }
}
