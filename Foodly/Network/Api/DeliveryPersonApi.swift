//
//  DeliveryPersonApi.swift
//  Foodly
//
//  Created by Decagon on 6/23/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum DeliveryPersonApi {
    case getDeliveryPersonDetails(restaurantID: String)
}

extension DeliveryPersonApi: FirestoreRequest {
    var collectionReference: CollectionReference? {
        switch self {
        case .getDeliveryPersonDetails(restaurantID: let restaurantID):
            return Firestore.firestore().collection(Collection.restaurant.identifier)
                .document(restaurantID).collection(Collection.delivery.identifier)
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.restaurant.identifier).document()
    }
    
    var tasks: Tasks {
        switch self {
        case .getDeliveryPersonDetails:
            return .read
        }
    }
    
    var documentReference: DocumentReference? {
        switch self {
        case .getDeliveryPersonDetails:
            return baseCollectionReference
        }
    }
    
    var collectionReferences: Query? {
        return Firestore.firestore().collection(Collection.categories.identifier).whereField("capital", isEqualTo: true)
    }
}
