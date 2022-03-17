//
//  Snapshot + Extensions.swift
//  Foodly
//
//  Created by Decagon on 5/31/21.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws  -> T {
        
        var documentJson = data()
        if includingId {
            documentJson?["id"] = documentID
        }
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJson as Any,
                                                      options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
    }
}
