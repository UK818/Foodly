//
//  collection.swift
//  Foodly
//
//  Created by Decagon on 6/5/21.
//

import Foundation

enum Collection {
    case users
    case orderHistory
    case restaurant
    case delivery
    case meals
    case userProfile
    case categories
    
    var identifier: String {
        switch self {
        case .users :
            return "users"
        case .orderHistory :
            return "order_history"
        case .restaurant:
            return "Restaurants"
        case .delivery:
            return "delivery"
        case .meals:
            return "meals"
        case .userProfile:
            return "user_profile"
        case .categories:
            return "categories"
        }
    }
}
