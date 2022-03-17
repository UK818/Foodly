//
//  OnboardingCollectionViewCell.swift
//  Foodly
//
//  Created by Usman on 31/05/2021.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnboardingCollectionViewCell"
    
    @IBOutlet weak var slideImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setUp(_ slide: OnboardingSlide) {
        slideImgView.image = slide.image
        titleLbl.text = slide.title
        descriptionLbl.text = slide.description
    }
}
