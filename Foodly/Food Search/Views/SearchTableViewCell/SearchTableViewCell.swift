//
//  SearchTableViewCell.swift
//  Foodly
//
//  Created by Decagon on 16/06/2021.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    func setup(with restaurant: Restaurants) {
        restaurantImage.kf.setImage(with: restaurant.restaurantImage.asUrl)
        restaurantName.text = restaurant.restaurantName
        mealName.text = restaurant.category
        timeLabel.text = restaurant.timeLabel
        discountLabel.text = restaurant.discountLabel
    }
}
