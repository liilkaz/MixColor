//
//  CharactersView.swift
//  MixColor
//
//  Created by Лилия Феодотова on 02.11.2023.
//

import UIKit

class CharactersView: UIView {
    
    let label: String
    
    init(label: String) {
        self.label = label
        super.init(frame: .zero)
        setupLabel()
    }
    
    lazy var character: UILabel = {
        let label = UILabel()
        label.text = self.label
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.textAlignment = .center
//        label.frame.size = CGSize(width: 20, height: 20)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        addSubviews(character)
        NSLayoutConstraint.activate([
            character.centerXAnchor.constraint(equalTo: centerXAnchor),
            character.heightAnchor.constraint(equalToConstant: 100),
//            character.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

}
