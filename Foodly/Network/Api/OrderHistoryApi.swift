//
//  OrderHistoryApi.swift
//  Foodly
//
//  Created by Decagon on 6/23/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum OrderHistoryApi {
    case getOrderHistory
}

extension OrderHistoryApi: FirestoreRequest {

    var collectionReference: CollectionReference? {
        switch self {
        case .getOrderHistory:
            return Firestore.firestore().collection(Collection.users.identifier)
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.restaurant.identifier).document()
    }
    
    var tasks: Tasks {
        switch self {
        case .getOrderHistory:
            return .read
        }
    }
    var documentReference: DocumentReference? {
        switch self {
        case .getOrderHistory:
            return baseCollectionReference
        }
        
    }
}
