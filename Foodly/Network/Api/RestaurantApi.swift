//
//  RestaurantApi.swift
//  Foodly
//
//  Created by Decagon on 6/21/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum RestaurantApi {
    case getRestaurant
}

extension RestaurantApi: FirestoreRequest {
    
    var collectionReference: CollectionReference? {
        switch self {
        case .getRestaurant:
            return Firestore.firestore().collection(Collection.restaurant.identifier)
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.restaurant.identifier).document()
    }
    
    var tasks: Tasks {
        switch self {
        case .getRestaurant:
            return .read
        }
    }
    var documentReference: DocumentReference? {
        switch self {
        case .getRestaurant:
            return baseCollectionReference
        }
    }
    var collectionReferences: Query? {
        return Firestore.firestore().collection(Collection.categories.identifier).whereField("capital", isEqualTo: true)
    }
}
