//
//  CountryFlagCollectionCell.swift
//  CricketCatalogUIKit
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import UIKit

class CountryFlagCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    var teamImageURL: String? {
        didSet {
            guard let teamImageURL else { return }
            imgView.image = UIImage(named: teamImageURL)
        }
    }
}

