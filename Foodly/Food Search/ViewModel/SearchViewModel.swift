//
//  SearchViewModel.swift
//  Foodly
//
//  Created by Decagon on 14/07/2021.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth

class SearchViewModel {
    var filteredData = [Restaurants]()
    var restaurant = [Restaurants]()
    
    var norifyPopRestaurantCompletion: (() -> Void)?
    var norifyRestaurantCatCompletion: (() -> Void)?
    
    func getPopRestaurants() {
        let getOrder = RestaurantService()
        getOrder.getRestaurant {(result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let result):
                result?.documents.forEach({ (doc) in
                    let data = doc.data()
                    if let name = data["name"] as? String, let time = data["cookingTime"] as? String,
                       let mealType = data["type"] as? String,
                       let discount = data["percentOff"] as?
                        String, let image = data["image"] as?
                        String {
                        let newrestaurant = Restaurants(restaurantName: name,
                                                        restaurantImage: image,
                                                        category: mealType,
                                                        timeLabel: time,
                                                        discountLabel: discount,
                                                        restaurantId: doc.documentID)
                        self.restaurant.append(newrestaurant)
                    }
                })
                self.filteredData = self.restaurant
                self.norifyPopRestaurantCompletion?()
                
            }
        }
    }
    
    func filterBySearchtext(searchText: String) {
        filteredData = []
        if searchText == "" {
            filteredData = restaurant
        }
        
        for restaurantSearched in restaurant {
            let searchByName = restaurantSearched.restaurantName.lowercased()
            let searchByMenu = restaurantSearched.category.lowercased()
            if searchByName.contains(searchText.lowercased()) || searchByMenu.contains(searchText.lowercased()) {
                filteredData.append(restaurantSearched)
            }
        }
        self.norifyPopRestaurantCompletion?()
    }
    
}
