//
//  DetailViewModel.swift
//  Foodly
//
//  Created by Decagon on 10/06/2021.
//

import Foundation
import UIKit

class DetailViewModel {
    
    var notifyError: ((String) -> Void)?
    var dataCompletion: (() -> Void)?
    var itemsUpdate: ((String, Int, Double) -> Void)?
    
    var meals = [ItemsDetailModel]()
    var restaurantData: Restaurants?
    var mealsCart = Set<ItemsDetailModel>()
    
    func promoDiscount() -> String {
        guard let discount = restaurantData?.discountLabel else {return ""}
        let discountedValue = discount.prefix(discount.count-5)
        return String(discountedValue)
    }
    
    func getMealss() {
        guard let restaurantData = restaurantData else { return }
        let getOrders = MealService()
        getOrders.getMeals(restaurantID: restaurantData.restaurantId) { (result) in
            switch result {
            case .failure(let error):
                self.notifyError?(error.localizedDescription)
            case .success(let result):
                result?.documents.forEach({ (doc) in
                    let data = doc.data()
                    if let name = data["name"] as? String, let price = data["price"] as? String,
                       let mealType = data["category"] as? String,
                       let image = data["image"] as?
                        String {
                        let newMeals = ItemsDetailModel(foodImage: image,
                                                        foodName: name,
                                                        foodType: mealType,
                                                        foodAmount: price,
                                                        foodID: doc.documentID,
                                                        foodQuantity: 0)
                        self.meals.append(newMeals)
                    }
                }
                )}
            self.dataCompletion?()
        }
    }
    
    func configureCart() {
        var totalAmount: Double = 0
        for meals in mealsCart {
            guard let value = Double(meals.foodAmount) else { return }
            totalAmount += value / 100
        }
        
        if mealsCart.count > 1 {
            itemsUpdate?("items", mealsCart.count, totalAmount)
        } else {
            itemsUpdate?("item", mealsCart.count, totalAmount)
        }
    }
}
