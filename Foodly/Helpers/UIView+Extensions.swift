//
//  UIView+Extensions.swift
//  FDAPersonalProject
//
//  Created by Korede on 30/05/2021.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
        }
    }
    
    private var identifier: String {
        return String(describing: self)
    }
}

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
