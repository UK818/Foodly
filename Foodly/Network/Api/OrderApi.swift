//
//  File.swift
//  Foodly
//
//  Created by Decagon on 6/5/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum OrderApi {
    case createFoodOrder(items: RequestParameter)
    case getFoodHistory
    case updateFoodHistory(foodID: String, items: Food)
    
}

extension OrderApi: FirestoreRequest {
    var baseCollectionReference: DocumentReference? {
        guard let userID = Auth.auth().currentUser?.uid else { return nil }
        return Firestore.firestore().collection("/users").document(userID)
    }
    
    var tasks: Tasks {
        switch self {
        case .createFoodOrder(let food):
            return .create(documentData: food.asParameter)
        case .getFoodHistory :
            return .read
        case .updateFoodHistory(_, let food):
            return .update(documentData: food.asParameter)
        }
    }
    
    var documentReference: DocumentReference? {
        switch self {
        case .createFoodOrder:
            return baseCollectionReference
        case .getFoodHistory:
            return baseCollectionReference?.collection("order_history").document("id")
        case .updateFoodHistory(_, _):
            return baseCollectionReference?.collection("order_history").document("id")
        }
        
    }
    
    var collectionReference: CollectionReference? {
        switch self {
        case .createFoodOrder:
            return baseCollectionReference?.collection(Collection.orderHistory.identifier)
        case .getFoodHistory:
            return baseCollectionReference?.collection(Collection.orderHistory.identifier)
        case .updateFoodHistory:
            return baseCollectionReference?.collection(Collection.orderHistory.identifier)
        }
        
    }
    var collectionReferences: Query? {
        return Firestore.firestore().collection(Collection.categories.identifier).whereField("capital", isEqualTo: true)
    }
}
