//
//  RestaurantTitleTableViewCell.swift
//  Foodly
//
//  Created by Decagon on 08/06/2021.
//

import UIKit

protocol RestaurantTitleTableViewCellDelegate: AnyObject {
    func moreDetails(with title: String)
}

class RestaurantTitleTableViewCell: UITableViewCell {
    
    static let identifier = "RestaurantTitleTableViewCell"
    weak var delegate: RestaurantTitleTableViewCellDelegate?
    
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var foodTypeLabel: UILabel!
    
    static func titleNib() -> UINib {
        return UINib(nibName: RestaurantTitleTableViewCell.identifier, bundle: nil)
    }
    
    public func configureItems(with model: Restaurants) {
        foodImageView.kf.setImage(with: model.restaurantImage.asUrl)
        foodNameLabel.text = model.restaurantName
        foodTypeLabel.text = model.category
    }
    @IBAction func seeMoreTapped(_ sender: UIButton) {
        delegate?.moreDetails(with: "See More")
        
    }
    
}
