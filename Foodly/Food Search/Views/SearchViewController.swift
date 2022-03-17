//
//  SearchViewController.swift
//  Foodly
//
//  Created by Decagon on 12/06/2021.
//

import UIKit

final class SearchViewController: UIViewController {
    private let viewModel = SearchViewModel()
    
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        viewModel.getPopRestaurants()
        searchTable.refreshControl = refreshControl
        searchTable.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        searchBar.delegate = self
        searchTable.register(UINib(nibName: "SearchTableViewCell",
                                   bundle: nil),
                             forCellReuseIdentifier: SearchTableViewCell.identifier)
        viewModel.norifyPopRestaurantCompletion = { [weak self] in
            DispatchQueue.main.async { [self] in
                self?.searchTable.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
        
    }
    
    @objc func pullToRefresh() {
        viewModel.restaurant.removeAll()
        refreshControl.beginRefreshing()
        viewModel.getPopRestaurants()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func getDetails(restaurant: Restaurants) {
        let restaurantDetailStoryboard = UIStoryboard(name: "RestaurantDetail", bundle: nil)
        let detailViewController = restaurantDetailStoryboard
            .instantiateViewController(identifier: "DetailViewController") as DetailViewController
        detailViewController.viewModel.restaurantData = restaurant
        detailViewController.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.tabBarController?.tabBar.isHidden = true
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTable
                .dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
                                     for: indexPath) as? SearchTableViewCell else {
                    return UITableViewCell()
                }
        cell.setup(with: viewModel.filteredData[indexPath.row])
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let restaurantMeal = viewModel.filteredData[indexPath.row]
        getDetails(restaurant: restaurantMeal)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterBySearchtext(searchText: searchText)
    }
}
