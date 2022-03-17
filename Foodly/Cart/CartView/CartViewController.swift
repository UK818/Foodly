//
//  CartViewController.swift
//  Foodly
//
//  Created by  on 12/06/2021.
//

import UIKit

final class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var initialTotalLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var finalTotalLbl: UILabel!
    @IBOutlet weak var promoCodeTextField: UITextField!
    @IBOutlet weak var addressOutlet: UITextField!
    
    let viewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressOutlet.delegate = self
        viewModel.getMeal()
        
        navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "Group 50"),
                                            style: UIBarButtonItem.Style.plain,
                                            target: self,
                                            action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        let nib = UINib(nibName: CartTableViewCell.identifier, bundle: nil)
        viewModel.getAddress()
        
        cartTableView.register(nib, forCellReuseIdentifier: CartTableViewCell.identifier)
        
        self.navigationItem.backButtonTitle = " "
        totalAmount(discount: viewModel.discount)
        viewModel.upDateDiscount = { updateValues in
            DispatchQueue.main.async {
                self.initialTotalLbl.text = updateValues.itemAmout
                self.finalTotalLbl.text = updateValues.cartTotal
                self.discountLbl.text = updateValues.itemDiscount
                self.taxLbl.text = updateValues.fixedtax
            }
        }
        viewModel.notificationCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.addressOutlet.text = self?.viewModel.address
            }
        }
    }
    
    func totalAmount(discount: Float) {
        viewModel.calculateTotal(discount: discount) { updateValues in
            DispatchQueue.main.async {
                self.initialTotalLbl.text = updateValues.itemAmout
                self.finalTotalLbl.text = updateValues.cartTotal
                self.discountLbl.text = updateValues.itemDiscount
                self.taxLbl.text = updateValues.fixedtax
            }
        }
        
    }
    
    @IBAction func continueBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "OrderConfirmation", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "OrderConfirmationViewController")
        as OrderConfirmationViewController
        controller.viewModels.restairantId = viewModel.restaurantId
        var proi = Food()
        proi.name = viewModel.restName
        proi.image = viewModel.image
        proi.items = String(viewModel.itemNumber)
        if let price = finalTotalLbl.text {
            proi.price = price
        }
        let request = OrderService()
        request.createOrder(with: proi) { (result) in
            switch result {
            case .success: print("")
            case .failure(let error): print(error.localizedDescription)
            }
        }
        
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func addPromoPressed(_ sender: UIButton) {
        guard let insertedCode = promoCodeTextField.text else {
            return
        }
        viewModel.fetchValues(insertedCode: insertedCode, completion: { alertTitle, theMessage in
            self.showAlert(alertText: alertTitle, alertMessage: theMessage)
        })
        
        totalAmount(discount: viewModel.discount)
    }
    @objc func back(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: CartTableViewCell.identifier) as? CartTableViewCell else {
                    return UITableViewCell()}
        cell.configueCartView(with: viewModel.mealsCartArray[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealsCartArray.count
    }
}

extension CartViewController: UITableViewDelegate, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = .orange
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.textColor = .white
        textField.returnKeyType = .done
        viewModel.updateAddress(view: self, addressOutlet.text ?? "Add Address")
        return true
    }
}

extension CartViewController: CartTableViewCellDelegate {
    
    func addBtnTapped(sender: CartTableViewCell, on plus: Bool) {
        if plus == true {
            let indexPath = cartTableView.indexPath(for: sender)
            viewModel.mealsCartArray[indexPath!.row].foodQuantity += 1
            viewModel.itemNumber += 1
        } else {
            let indexPath = cartTableView.indexPath(for: sender)
            viewModel.mealsCartArray[indexPath!.row].foodQuantity -= 1
            viewModel.itemNumber -= 1
            if viewModel.mealsCartArray[indexPath!.row].foodQuantity >= 1 {
            } else if viewModel.mealsCartArray[indexPath!.row].foodQuantity == 0 {
                viewModel.mealsCartArray.remove(at: indexPath!.row)
            }
        }
        totalAmount(discount: viewModel.discount)
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
    }
}

// let locale = Locale(identifier: "en_US")
// let formatter = NumberFormatter()
// formatter.locale = locale
// formatter.numberStyle = .currency
// formatter.maximumFractionDigits = 2
// let numebr = NSNumber(value: 400.0)
// formatter.string(from: numebr)
