//
//  RestaurantsViewModel.swift
//  Foodly
//
//  Created by omokagbo on 08/06/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class RestaurantsViewModel {
    
    var restaurant = [Restaurants]()
    var restaurantCategories = [Restaurants]()
    var emptyArray = [Restaurants]()
    var firstWord = ""
    var greetings = ""
    var usernameHandler: (() -> Void)?
    
    init() {
        greetings = gettime()
    }
    
    var norifyPopRestaurantCompletion: (() -> Void)?
    var norifyRestaurantCatCompletion: (() -> Void)?
    
    func getPopRestaurants() {
        let getOrder = RestaurantService()
        getOrder.getRestaurant { (result) in
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
                self.norifyPopRestaurantCompletion?()
                
            }
        }
    }
    func getPopularRestaurants() {
        
    }
    func getCategories(type: String) {
        let getOrder = RestaurantCatService()
        self.restaurant.removeAll()
        getOrder.getRestCatDetails(type: type) { (result) in
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
                self.norifyPopRestaurantCompletion?()
            }
        }
    }
    
    func getUserName() {
        let docId = Auth.auth().currentUser?.uid
        let docRef = Firestore.firestore().collection("/users").document("\(docId!)")
        docRef.getDocument {(document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let status = docData!["fullName"] as? String ?? ""
                let firstWord = status.components(separatedBy: " ").first
                self.greetings = "\(self.gettime()), \(firstWord!)"
                self.usernameHandler?()
            } else {
                debugPrint(error as Any)
            }
        }
    }
    
    func gettime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 1..<12 :
            return(NSLocalizedString("Good Morning", comment: "Morning"))
        case 12..<17 :
            return (NSLocalizedString("Good Afternoon", comment: "Afternoon"))
        default:
            return (NSLocalizedString("Good Evening", comment: "Evening"))
        }
    }
}
