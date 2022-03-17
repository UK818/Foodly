//
//  User.swift
//  Foodly
//
//  Created by Decagon on 6/8/21.
//

import Foundation
protocol Identifiable {
    var userID: String? { get set }
}
struct User: Codable, Identifiable {
    var userID: String?
    let fullName: String
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case fullName
        case email
        case password
    }
    
    init(fullName: String, email: String, password: String) {
        self.fullName = fullName
        self.email = email
        self.password = password
    }
}
