//
//  DetailViewController.swift
//  Foodly
//
//  Created by Decagon on 08/06/2021.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var numberOfItems: UILabel!
    @IBOutlet weak var newTableView: UITableView!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var item: UILabel!
    
    let viewModel = DetailViewModel()
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavigation()
        cartView.isHidden = viewModel.mealsCart.isEmpty
        view.addSubview(cartView)
        setupViewModelListeners()
    }
    
    private func setupTable() {
        newTableView.register(RestaurantItemsTableViewCell.itemNib(),
                              forCellReuseIdentifier: RestaurantItemsTableViewCell.identifier)
        newTableView.register(RestaurantTitleTableViewCell.titleNib(),
                              forCellReuseIdentifier: RestaurantTitleTableViewCell.identifier)
        newTableView.delegate = self
        newTableView.dataSource = self
        newTableView.showsVerticalScrollIndicator = false
        newTableView.separatorStyle = .none
        newTableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    private func setupNavigation() {
        self.setNavBar()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "Group 50"),
                                            style: UIBarButtonItem.Style.plain,
                                            target: self,
                                            action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        self.navigationItem.backButtonTitle = " "
        title = viewModel.restaurantData?.restaurantName
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    private func setupViewModelListeners() {
        viewModel.getMealss()
        viewModel.dataCompletion = {
            DispatchQueue.main.async {
                self.newTableView.reloadData()
                self.newTableView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.notifyError = { [weak self] error in
            self?.showAlert(alertText: "Error", alertMessage: "\(error)")
        }
        
        viewModel.itemsUpdate = { [weak self] itemDetail, number, total in
            self?.item.text = itemDetail
            self?.numberOfItems.text = "\(number)"
            self?.totalAmount.text = "$\(String(format: "%.2f", total))"
        }
    }
    
    @objc func handleRefreshControl() {
        self.viewModel.getMealss()
        self.newTableView.refreshControl?.beginRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.newTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setNavBar()
    }
    
    @IBAction func viewCartButton(_ sender: UIButton) {
        let newStoryboard = UIStoryboard(name: "Cart", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "CartViewController") as CartViewController
        newController.viewModel.mealsCart = viewModel.mealsCart
        newController.title = "Cart"
        newController.viewModel.parsedDiscount = viewModel.promoDiscount()
        if let restaurantData = viewModel.restaurantData {
            newController.viewModel.restName = restaurantData.restaurantName
            newController.viewModel.image = restaurantData.restaurantImage
        }
        if let restaurantId =  viewModel.restaurantData?.restaurantId {
        newController.viewModel.restaurantId = restaurantId
        }
        navigationController?.pushViewController(newController, animated: true)
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meals.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = UIView(frame: CGRect(x: 0,
                                        y: 0, width: view.frame.size.width, height: 50))
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: RestaurantTitleTableViewCell
                                        .identifier) as? RestaurantTitleTableViewCell else {
            return UIView()
        }
        
        self.newTableView.tableHeaderView = cell
        cell.delegate = self
        if let restaurantData = viewModel.restaurantData {
            cell.configureItems(with: restaurantData)
        }
        return head
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: RestaurantItemsTableViewCell
                                        .identifier, for: indexPath) as?
                RestaurantItemsTableViewCell else { return UITableViewCell() }
        cell.configureItems(with: viewModel.meals[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    @objc func back(sender: UIBarButtonItem) {
        if  self.num >= 1 {
            DispatchQueue.main.async {
                self.newTableView.tableHeaderView?.frame = CGRect(x: 0,
                                                                  y: 0,
                                                                  width: self.view.frame.size.width,
                                                                  height: 50)
                self.newTableView.reloadData()
                self.num = 0
            }
             } else {
                navigationController?.popViewController(animated: true)
    }
}
}

extension DetailViewController: RestaurantItemsTableViewCellDelegate {
    
    func didTapAddBtn(with item: ItemsDetailModel) {
        viewModel.mealsCart.insert(item)
        cartView.isHidden = viewModel.mealsCart.isEmpty
        self.viewModel.configureCart()
    }
    
    func didTapRemoveBtn(with item: ItemsDetailModel) {
        viewModel.mealsCart.remove(item)
        cartView.isHidden = viewModel.mealsCart.isEmpty
        self.viewModel.configureCart()
    }
}

extension DetailViewController: RestaurantTitleTableViewCellDelegate {
    func moreDetails(with title: String) {
        self.newTableView.beginUpdates()
        self.newTableView.sectionHeaderHeight = 0.0
        self.newTableView.frame = self.view.bounds
        self.newTableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.num += 1
        self.newTableView.endUpdates()
    }
}
