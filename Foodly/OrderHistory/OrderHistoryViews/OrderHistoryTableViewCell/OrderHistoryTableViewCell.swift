//
//  OrderHistoryTableViewCell.swift
//  Foodly
//
//  Created by Decagon on 6/23/21.
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {
    
    static let identifier = "OrderHistoryTableViewCell"
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var numberOfItems: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    public func configureOrderHistoryView(with model: OrderHistoryModel ) {
        restaurantImage.kf.setImage(with: model.restaurantImage.asUrl)
        restaurantName.text = model.restaurantName
        if let itemQuantity = Int(model.itemQuantity) {
            if itemQuantity > 1 {
                numberOfItems.text = "x \(itemQuantity) items"
            } else {
                numberOfItems.text = "x \(itemQuantity) item"
            }
        }
        totalPrice.text = "\(model.totalPrice)"
    }
}
