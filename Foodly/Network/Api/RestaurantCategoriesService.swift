//
//  restaurantCategoriesService.swift
//  Foodly
//
//  Created by Decagon on 7/4/21.
//

import Foundation

struct RestaurantCatService {
    let router = Router<RestaurantCategoriesApi>()
    
    func getRestCatDetails(type: String, completion: @escaping NetworkRouterCompletion) {
        router.request(.getRestCategories(type: type), completion: completion)
    }
}
