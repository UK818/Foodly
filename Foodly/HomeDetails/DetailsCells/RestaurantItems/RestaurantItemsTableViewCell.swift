//
//  RestaurantItemsTableViewCell.swift
//  Foodly
//
//  Created by Decagon on 08/06/2021.
//

import UIKit

protocol RestaurantItemsTableViewCellDelegate: AnyObject {
    func didTapAddBtn(with item: ItemsDetailModel)
    func didTapRemoveBtn(with item: ItemsDetailModel)
}

class RestaurantItemsTableViewCell: UITableViewCell {
    
    weak var delegate: RestaurantItemsTableViewCellDelegate?
    private var itemsDetailModel: ItemsDetailModel?
    
    static let identifier = "RestaurantItemsTableViewCell"
    
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var foodTypeLabel: UILabel!
    @IBOutlet var foodAmountLabel: UILabel!
    
    static func itemNib() -> UINib {
        return UINib(nibName: RestaurantItemsTableViewCell.identifier, bundle: nil)
    }
    
    private func configureAddBtn(for selectedState: Bool) {
        self.reloadInputViews()
        addBtn.setImage(UIImage(systemName: selectedState ? "checkmark" : "plus"), for: .normal)
        addBtn.backgroundColor =  selectedState ?  #colorLiteral(red: 0.4292169809, green: 0.3801349998, blue: 0.947272718, alpha: 1) : .systemGray6
        addBtn.tintColor = selectedState ? #colorLiteral(red: 0.9724192023, green: 0.9724631906, blue: 0.9805964828, alpha: 1) : #colorLiteral(red: 0.4292169809, green: 0.3801349998, blue: 0.947272718, alpha: 1)
        addBtn.setTitle(selectedState ? "Added  " : "Add  ", for: .normal)
        addBtn.setTitleColor(selectedState ? #colorLiteral(red: 0.9724192023, green: 0.9724631906, blue: 0.9805964828, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        self.reloadInputViews()
    }
    
    @IBAction func didTapAddBtn() {
        guard let itemsDetails = itemsDetailModel else { return }
        if itemsDetails.foodQuantity <= 0 {
            itemsDetails.foodQuantity = 1
            delegate?.didTapAddBtn(with: itemsDetails)
        } else {
            itemsDetails.foodQuantity = 0
            delegate?.didTapRemoveBtn(with: itemsDetails)
        }
        configureAddBtn(for: itemsDetails.foodQuantity > 0)
    }
    
    public func configureItems(with model: ItemsDetailModel) {
        foodImageView.kf.setImage(with: model.foodImage.asUrl)
        foodNameLabel.text = model.foodName
        foodTypeLabel.text = model.foodType
        foodAmountLabel.text = "$\(Double(model.foodAmount)!/100)"
        itemsDetailModel = model
    }
}
