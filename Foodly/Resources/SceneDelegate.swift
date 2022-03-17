//
//  SceneDelegate.swift
//  Foodly
//
//  Created by Decagon on 29/05/2021.
//

import UIKit
import FirebaseAuth
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let defaults = UserDefaults.standard
    
    func navigateToRootView(storyBoardName: String, viewControllerName: String) {
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: viewControllerName)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
//        guard let _ = (scene as? UIWindowScene) else { return }
        AppDelegate.standard.window = window

        let lastSignInDate = Auth.auth().currentUser?.metadata.lastSignInDate
        let lastLoginHour = Calendar.current.component(.hour, from: lastSignInDate ?? Date() )
        let currentTime = Calendar.current.component(.hour, from: Date() )
        let timeDifference = currentTime - lastLoginHour
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        if defaults.bool(forKey: "First Launch") == true {
            if Auth.auth().currentUser == nil  || timeDifference > 24 {
                navigateToRootView(storyBoardName: "Login", viewControllerName: "LoginViewController")
            } else {
                navigateToRootView(storyBoardName: "Home", viewControllerName: "HomeTabBarNav")
            }
            
        } else {
            navigateToRootView(storyBoardName: "Main", viewControllerName: "OnboardingViewController")
            
        }
        defaults.setValue(true, forKey: "First Launch")
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
}
