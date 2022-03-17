//
//  MealApi.swift
//  Foodly
//
//  Created by Decagon on 6/21/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum MealApi {
    case getMeal(restaurantID: String)
}

extension MealApi: FirestoreRequest {
    var collectionReference: CollectionReference? {
        switch self {
        case .getMeal(restaurantID: let restaurantID):
            return Firestore.firestore().collection(Collection.restaurant.identifier)
                .document(restaurantID).collection(Collection.meals.identifier)
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        Firestore.firestore().collection(Collection.restaurant.identifier).document()
    }
    
    var tasks: Tasks {
        switch self {
        case .getMeal:
            return .read
        }
    }
    
    var documentReference: DocumentReference? {
        switch self {
        case .getMeal:
            return baseCollectionReference?.collection("order_history").document("id")
        }
    }
    var collectionReferences: Query? {
        return Firestore.firestore()
            .collection(Collection.categories.identifier)
            .whereField("capital", isEqualTo: true)
    }
}
