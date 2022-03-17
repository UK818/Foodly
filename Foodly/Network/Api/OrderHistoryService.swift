//
//  OrderHistoryService.swift
//  Foodly
//
//  Created by Decagon on 6/23/21.
//

import Foundation
struct OrderHistoryService {
    let router = Router<orderHistoryApi>()
    
    func getOrderHistory(completion: @escaping NetworkRouterCompletion) {
        router.request(.getOrderHistory(completion: completion))
    }
    
}
