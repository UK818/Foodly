//
//  OrderHistoryViewController.swift
//  Foodly
//
//  Created by omokagbo on 16/06/2021.
//

import UIKit

class OrderHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    let orderHistoryViewModels = OrderHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
        table.register(UINib(nibName: OrderHistoryTableViewCell.identifier,
                             bundle: nil),
                       forCellReuseIdentifier: OrderHistoryTableViewCell.identifier)
        orderHistoryViewModels.get()
        setupCompletionHandlerListener()
        self.navigationItem.backButtonTitle = ""
//        table.refreshControl = UIRefreshControl()
//        table.refreshControl?.addTarget(self,
//                                        action: #selector(handleRefreshControl),
//                                        for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        orderHistoryViewModels.orderHistoryArray.removeAll()
        self.table.refreshControl?.beginRefreshing()
        self.orderHistoryViewModels.get()
       
    }
    
    fileprivate func setupCompletionHandlerListener() {
        orderHistoryViewModels.notifyCompletion = { [weak self] in
            DispatchQueue.main.async {
//                self?.table.refreshControl?.endRefreshing()
                self?.table.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderHistoryViewModels.orderHistoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: OrderHistoryTableViewCell.identifier,
                                                   for: indexPath) as? OrderHistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.configureOrderHistoryView(with: orderHistoryViewModels.orderHistoryArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
