//
//  Food.swift
//  Foodly
//
//  Created by Decagon on 6/6/21.
//
import Foundation

struct Food {
    var name = ""
    var price = ""
    var items = ""
    var image = ""
}
extension Food: RequestParameter {
    
    var asParameter: Parameter {
        return ["food": name, "price": price, "items": items, "image": image]
    }
}
