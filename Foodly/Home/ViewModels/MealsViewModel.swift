//
//  MealsViewModel.swift
//  Foodly
//
//  Created by omokagbo on 08/06/2021.
//

import UIKit

import FirebaseFirestore

class MealsViewModel {
    var categories = [Meals]()
    var notifyCompletion: (() -> Void)?
    var notifysCompletion: (() -> Void)?
    
    func getMealCategories() {
        let getOrder = MealsCategoriesService()
        getOrder.getMealsCategories { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let result):
                result?.documents.forEach({ (doc) in
                    let data = doc.data()
                    if let name = data["name"] as? String, let image = data["image"] as?
                        String {
                        let newCategory = Meals(name: name, image: image)
                        self.categories.append(newCategory)
                    }
                })
                self.notifyCompletion?()
            }
            
        }
    }
}
