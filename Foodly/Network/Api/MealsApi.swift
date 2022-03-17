//
//  MealsApi.swift
//  Foodly
//
//  Created by Decagon on 7/4/21.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

enum MealsApi {
    case getMealsCategories
}

extension MealsApi: FirestoreRequest {
    
    var collectionReference: CollectionReference? {
        switch self {
        case .getMealsCategories:
            return Firestore.firestore().collection(Collection.categories.identifier)
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.categories.identifier).document()
    }
    
    var tasks: Tasks {
        switch self {
        case .getMealsCategories:
            return .read
        }
    }
    var documentReference: DocumentReference? {
        switch self {
        case .getMealsCategories:
            return baseCollectionReference
        }
    }
    var collectionReferences: Query? {
        return Firestore.firestore().collection(Collection.categories.identifier).whereField("capital", isEqualTo: true)
    }
    
}
