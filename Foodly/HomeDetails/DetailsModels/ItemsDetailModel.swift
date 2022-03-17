//
//  ItemsDetailModel.swift
//  Foodly
//
//  Created by Decagon on 08/06/2021.
//

import Foundation

class ItemsDetailModel {
    let foodImage, foodName, foodType, foodAmount, foodID: String
    var foodQuantity: Int
    
    init(foodImage: String, foodName: String, foodType: String, foodAmount: String, foodID: String, foodQuantity: Int) {
        self.foodImage = foodImage
        self.foodName = foodName
        self.foodType = foodType
        self.foodAmount = foodAmount
        self.foodID = foodID
        self.foodQuantity = foodQuantity
    }
}

extension ItemsDetailModel: Hashable {
    static func == (lhs: ItemsDetailModel, rhs: ItemsDetailModel) -> Bool {
        return lhs.foodID == rhs.foodID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(foodID)
    }
}
