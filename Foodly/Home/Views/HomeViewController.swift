//
//  HomeViewController.swift
//  Foodly
//
//  Created by omokagbo on 07/06/2021.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    @IBOutlet weak var popularRestaurantsTableView: UITableView!
    
    private let viewModel = RestaurantsViewModel()
    private let mealsViewModel = MealsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        navigationItem.backButtonTitle = " "
        navigationController?.navigationBar.isHidden = true
        welcomeLabel.text = viewModel.greetings
        viewModel.getUserName()
        mealsViewModel.getMealCategories()
        viewModel.getPopRestaurants()
        popularRestaurantsTableView.register(UINib(nibName: RestaurantsTableViewCell.identifier,
                                                   bundle: nil),
                                             forCellReuseIdentifier: RestaurantsTableViewCell.identifier)
        
        foodCollectionView.allowsMultipleSelection = false
        setupViewModelListeners()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setNavBar()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.backgroundColor = .systemBackground
        DispatchQueue.main.async {
            self.popularRestaurantsTableView.reloadData()
        }
    }
    
    fileprivate func setupViewModelListeners() {
        mealsViewModel.notifyCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.foodCollectionView.reloadData()
            }
            
        }
        viewModel.norifyPopRestaurantCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.popularRestaurantsTableView.reloadData()
            }
            
        }
        viewModel.usernameHandler = { [weak self] in
            self?.welcomeLabel.text = self?.viewModel.greetings
            self?.welcomeLabel.font = UIFont(name: "Helvetica", size: 25.0)
            self?.welcomeLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mealsViewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: MealsCollectionViewCell.identifier,
                                                                for: indexPath) as? MealsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: mealsViewModel.categories[indexPath.row])
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MealsCollectionViewCell
        cell?.mealImageView.backgroundColor = foodlyPurple
        let mealName = mealsViewModel.categories[indexPath.row].name
        if indexPath.row == 0 {
            self.viewModel.getPopRestaurants()
        } else {
            viewModel.getCategories(type: mealName)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MealsCollectionViewCell
        cell?.mealCategorySelected()
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(viewModel.restaurant.count, 5)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = popularRestaurantsTableView
                .dequeueReusableCell(withIdentifier: RestaurantsTableViewCell.identifier,
                                     for: indexPath) as? RestaurantsTableViewCell else {
                    return UITableViewCell()
                }
        cell.setup(with: viewModel.restaurant[indexPath.row])
        return cell
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let restaurantMeal = viewModel.restaurant[indexPath.row]
        let restaurantDetailStoryboard = UIStoryboard(name: "RestaurantDetail", bundle: nil)
        let detailViewController = restaurantDetailStoryboard
            .instantiateViewController(identifier: "DetailViewController") as DetailViewController
        detailViewController.viewModel.restaurantData = restaurantMeal
        navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.tabBarController?.tabBar.isHidden = true
    }
}
