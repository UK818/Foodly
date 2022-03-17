//
//  OrderConfirmationViewController.swift
//  Foodly
//
//  Created by Decagon on 6/16/21.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var deliveryPersonNameLabel: UILabel!
    @IBOutlet weak var deliveryPersonImage: UIImageView!
    @IBOutlet weak var orderConfirmedTick: UIImageView!
    @IBOutlet weak var orderPreparedTick: UIImageView!
    @IBOutlet weak var deliveryInProgressTick: UIImageView!
    @IBOutlet weak var orderConfirmationBackground: UIView!
    @IBOutlet weak var orderConfirmedbackground: UIView!
    @IBOutlet weak var deliveryBackgroung: UIView!
    @IBOutlet weak var deliveryReadyTick: UIImageView!
    
    var viewModels = OrderConfirmationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        self.navigationItem.hidesBackButton = true
        viewModels.deliver(restaurantId: viewModels.restairantId)
        setupViewModelListener()
    }
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deliveryManNumber(_ sender: UIButton) {
        if let url = URL(string: "tel://\(self.viewModels.deliveryDetail.first?.phones ?? "111" )"),
           UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            debugPrint("Error")
        }
    }
    
    @objc func preparedTick() {
        self.orderPreparedTick.image = UIImage(named: "Vector (3)")
        self.orderConfirmationBackground.backgroundColor = orderConfirmedbackground.backgroundColor
    }
    
    @objc func deliveryTick() {
        self.deliveryReadyTick.image = UIImage(named: "Vector (3)")
        self.deliveryBackgroung.backgroundColor = orderConfirmedbackground.backgroundColor
    }
    
    fileprivate func setupViewModelListener() {
        viewModels.notifyCompletion = { [weak self] in
            DispatchQueue.main.async {
                if let deliveryTime = self?.viewModels.deliveryDetail.first?.delivery {
                    self?.deliveryTimeLabel.text = "\(deliveryTime) mins"
                }
                self?.deliveryPersonNameLabel.text = self?.viewModels.deliveryDetail.first?.names
                self?.deliveryPersonImage.kf.setImage(with: self?.viewModels.deliveryDetail.first?.images.asUrl)
                self?.perform(#selector(self?.preparedTick), with: nil,
                              afterDelay: self?.viewModels.deliveryDetail.first?.preparationTime ?? 1)
                self?.perform(#selector(self?.deliveryTick), with: nil,
                              afterDelay: self?.viewModels.deliveryDetail.first?.deliveryTime ?? 1)
            }
        }
    }
}
