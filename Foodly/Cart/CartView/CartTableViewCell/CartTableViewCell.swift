//
//  CartTableViewCell.swift
//  Foodly
//
//  Created by Decagon on 15/06/2021.
//

import UIKit

protocol CartTableViewCellDelegate: AnyObject {
    func addBtnTapped(sender: CartTableViewCell, on plus: Bool)
}

class CartTableViewCell: UITableViewCell {
    
    var tableViewModel = CartViewModel()
    private let viewModel = CartViewModel()
    
    static let identifier = "CartTableViewCell"
    weak var delegate: CartTableViewCellDelegate?
    
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var itemTitleLbl: UILabel!
    @IBOutlet var numberOfItems: UILabel!
    @IBOutlet var amountLbl: UILabel!
    
    public func configueCartView(with model: ItemsDetailModel) {
        titleImageView.kf.setImage(with: model.foodImage.asUrl)
        itemTitleLbl.text = model.foodName
        numberOfItems.text = "\(model.foodQuantity)"
        guard let foodAmount = Float(model.foodAmount) else { return }
        let foodQty = Float(model.foodQuantity)
        amountLbl.text = "$\(String(format: "%.2f", foodAmount / 100 * foodQty))"
    }
    
    @IBAction func minusBtnTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.addBtnTapped(sender: self, on: false)
            
        }
    }
    @IBAction func plusBtnTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.addBtnTapped(sender: self, on: true)
        }
    }
}
