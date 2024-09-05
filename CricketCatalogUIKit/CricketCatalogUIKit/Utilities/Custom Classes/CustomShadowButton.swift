//
//  CustomShadowButton.swift
//  CricketCatalogUIKit
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import UIKit

class CustomShadowButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupButton()
    }

    private func setupButton() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0
    }
}

