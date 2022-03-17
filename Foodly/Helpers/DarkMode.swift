//
//  DarkMode.swift
//  Foodly
//
//  Created by Decagon on 29/05/2021.
//

import UIKit

enum AssetsColor: String {
    case generalScreenBackgroundColor
    case buttonBackgroundColor
    case otherLabelColour
    case titleLabelColour
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}

let foodlyPurple = UIColor.appColor(.buttonBackgroundColor)
let backgroundColor = UIColor.appColor(.generalScreenBackgroundColor)
let labelColor = UIColor.appColor(.otherLabelColour)
let titleTextColor = UIColor.appColor(.titleLabelColour)

//  Example usage: view.backgroundColor = backgroundColor

// When using storyboard:
/*
 The custom colour assets are:
 1. generalScreenBackgroundColor - For all the screen backgrounds
 2. otherLabelColour - For all other labels except title
 3. buttonBackgroundColor - For all the button backgrounds. The colour for the button text is .white
 4. titleLabelColour - For all title texts on screen like Login, Signup etc
 */
