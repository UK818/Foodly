//
//  TextField+Extension.swift
//  Foodly
//
//  Created by omokagbo on 30/05/2021.
//

import UIKit

class PaddedTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class SearchPadding: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 20)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
