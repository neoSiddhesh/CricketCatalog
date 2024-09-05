//
//  TeamPlayerCell.swift
//  CricketCatalogUIKit
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import UIKit

class TeamPlayerCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var player: Player? {
        didSet {
            guard let player else { return }
            lblTitle.text = player.name
            lblSubTitle.text = player.role
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupBgView()
    }
    
    private func setupBgView() {
        bgView.layer.borderColor = UIColor.systemGray5.cgColor
        bgView.layer.borderWidth = 1.0
        bgView.layer.cornerRadius = 20.0
        bgView.layer.masksToBounds = true
    }
    
    func bindData(player: Player?) {
        guard let player else { return }
        lblTitle.text = player.name
        lblSubTitle.text = player.role
    }
}
