//
//  OnboardingViewModel.swift
//  Foodly
//
//  Created by Usman on 09/06/2021.
//

import Foundation

class OnboardingViewModel {
    var slides: [OnboardingSlide] = []
    var updateButton: ((String, Int, String) -> Void)?
    var currentPage = 0 {
        didSet {
            if currentPage == slides.count - 1 {
                updateButton?("Get Started", currentPage, "")
            } else {
                updateButton?("Next", currentPage, "Skip")
            }
        }
    }
    
    init() {
        slides = [
            // swiftlint:disable:next line_length
            OnboardingSlide(title: "Only Healthy Variety", description: "Healthy eating means eating a variety of foods that give you the nutrients you need to maintain your health, feel good and have energy.", image: #imageLiteral(resourceName: "Frame")), OnboardingSlide(title: "Choose A Tasty Meal", description: "Order anything you want from your favorite restaurant.", image: #imageLiteral(resourceName: "Frame-2")), OnboardingSlide(title: "Easy Payment", description: "Payment made easy through debit card, credit card & more ways to pay for your food..", image: #imageLiteral(resourceName: "Frame-3"))
        ]
    }
}
