//
//  CountryFlagHeaderView.swift
//  CricketCatalogUIKit
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import UIKit

class CountryFlagHeaderView: UIView {
    
    @IBOutlet weak var flagCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var teams: [Team] = [] {
        didSet {
            pageControl.numberOfPages = teams.count
            flagCollectionView.reloadData()
        }
    }
    var didChangeTeam: ((_ index: Int) -> Void)?
    private var currentCarouselIndex = 0
    
    static func loadView() -> CountryFlagHeaderView? {
        guard let view = Bundle.main
            .loadNibNamed(Constants.countryFlagHeaderView, owner: self, options: nil)?[0]
                as? CountryFlagHeaderView else {
            return nil
        }
        view.setupTeamTableHeaderView()
        return view
    }
    
    private func setupTeamTableHeaderView() {
        flagCollectionView.register(UINib(nibName: Constants.countryFlagCollectionCell, bundle: nil), forCellWithReuseIdentifier: Constants.countryFlagCollectionCell)
        flagCollectionView.decelerationRate = .fast
        flagCollectionView.dataSource = self
        flagCollectionView.delegate = self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        pageControl.currentPage = 0
        flagCollectionView.dataSource = self
        flagCollectionView.delegate = self
        let nib = UINib(nibName: Constants.countryFlagCollectionCell, bundle: nil)
        flagCollectionView.register(nib, forCellWithReuseIdentifier: Constants.countryFlagCollectionCell)
    }
}


extension CountryFlagHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = flagCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.countryFlagCollectionCell, for: indexPath) as? CountryFlagCollectionCell else {
            return UICollectionViewCell()
        }
        cell.teamImageURL = teams[indexPath.row].teamImageURL
        return cell
    }
}


extension CountryFlagHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = flagCollectionView.bounds.height
        let width = flagCollectionView.bounds.width
        return CGSize(width: width, height: height)
    }
}


extension CountryFlagHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.visibleCells.first,
           let indexpath =  collectionView.indexPath(for: cell) {
            pageControl.currentPage = indexpath.row
            didChangeTeam?(indexpath.row)
        }
    }
}

