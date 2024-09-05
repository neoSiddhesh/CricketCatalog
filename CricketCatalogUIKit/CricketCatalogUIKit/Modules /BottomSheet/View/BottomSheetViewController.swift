//
//  BottomSheetViewController.swift
//  CricketCatalogUIKit
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    @IBOutlet weak var lblTotalPlayer: UILabel!
    
    var viewModel: BottomSheetViewModelProtocol = BottomSheetViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }

    private func bindData() {
        lblTotalPlayer.text = "Players count (\(viewModel.player.count))"
        
        guard let results = viewModel.topThreeCharacters().characterOccurence else {
            return
        }
        let labels = [lblFirst, lblSecond, lblThird]
        for (index, result) in results.enumerated() where index < labels.count {
            labels[index]?.text = viewModel.getCharacterCountString(result: result)
        }
    }
}

