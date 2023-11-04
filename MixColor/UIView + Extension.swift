//
//  UIView + Extension.swift
//  MixColor
//
//  Created by Лилия Феодотова on 02.11.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }
}
