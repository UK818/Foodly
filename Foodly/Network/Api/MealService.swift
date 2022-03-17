//
//  MealService.swift
//  Foodly
//
//  Created by Decagon on 6/21/21.
//

import Foundation

struct MealService {
    let router = Router<MealApi>()
    
    func getMeals(restaurantID: String, completion: @escaping NetworkRouterCompletion) {
        router.request(.getMeal(restaurantID: restaurantID ), completion: completion)
    }
}
