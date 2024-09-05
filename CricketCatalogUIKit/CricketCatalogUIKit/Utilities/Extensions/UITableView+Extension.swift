//
//  UITableView+Extension.swift
//  CricketCatalogUIKit
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import UIKit

extension UITableView {
    func displayMessage(text: String) {
        let label = UILabel(frame: self.frame)
        label.text = text
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.tag = 10
        self.addSubview(label)
    }
    
    func hideMessage() {
        _ = self.subviews.filter({ $0.tag == 10 }).map({ $0.removeFromSuperview() })
    }
}

