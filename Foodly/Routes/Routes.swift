//
//  Routes.swift
//  Foodly
//
//  Created by Usman on 10/06/2021.
//

import UIKit

class Routes {
	
	func skippedToLogin() {
		let newStoryboard = UIStoryboard(name: "Login", bundle: nil)
		let newController = newStoryboard
			.instantiateViewController(identifier: "LoginViewController") as LoginViewController
		newController.modalTransitionStyle = .crossDissolve
		newController.modalPresentationStyle = .fullScreen
		OnboardingViewController().present(newController, animated: true, completion: nil)
	}
	
}
