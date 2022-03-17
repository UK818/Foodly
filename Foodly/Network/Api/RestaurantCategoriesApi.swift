//
//  restaurantCategoriesApi.swift
//  Foodly
//
//  Created by Decagon on 7/4/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum RestaurantCategoriesApi {
    case getRestCategories(type: String)
}

extension RestaurantCategoriesApi: FirestoreRequest {
    var collectionReference: CollectionReference? {
        return Firestore.firestore().collection(Collection.restaurant.identifier)
    }
    
    var collectionReferences: Query? {
        switch self {
        case .getRestCategories(let type):
            return Firestore.firestore()
                .collection(Collection.restaurant.identifier)
                .whereField("type", isEqualTo: type)
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.categories.identifier).document()
    }
    
    var tasks: Tasks {
        switch self {
        case .getRestCategories(let type):
            return .qread(type: type)
        }
    }
    var documentReference: DocumentReference? {
        switch self {
        case .getRestCategories:
            return baseCollectionReference
        }
    }
}
