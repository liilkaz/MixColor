//
//  ColorView.swift
//  MixColor
//
//  Created by Лилия Феодотова on 02.11.2023.
//

import UIKit

class ColorView: UIView {
    
    let nameColor: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let colorBox: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(color: UIColor){
        nameColor.text = color.accessibilityName
        colorBox.backgroundColor = color
    }
    
//    func updateLabel(lang: String) {
//        nameColor.text = colorBox.backgroundColor?.accessibilityName
//    }
    
    func setupView() {
        addSubviews(nameColor, colorBox)
        NSLayoutConstraint.activate([
            nameColor.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            colorBox.topAnchor.constraint(equalTo: nameColor.bottomAnchor, constant: 5),
            colorBox.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorBox.heightAnchor.constraint(equalToConstant: 100),
            colorBox.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}


