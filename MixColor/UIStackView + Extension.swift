//
//  UIStackView + Extension.swift
//  MixColor
//
//  Created by Лилия Феодотова on 02.11.2023.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init()
        self.axis = axis
        self.spacing = spacing
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        })
    }
}
