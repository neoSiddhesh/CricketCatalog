//
//  TeamViewController.swift
//  CricketCatalogUIKit
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import Foundation

import UIKit

class TeamViewController: UIViewController {
    
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var floatingBtn: UIButton!

    private var viewModel: TeamViewModelProtocol = TeamViewModel()
    private var countryFlagHeaderView: CountryFlagHeaderView? = CountryFlagHeaderView.loadView()
    private let searchBar = CustomSearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpObsevrers()
    }
    
    private func setUpObsevrers() {
        viewModel.successBlock = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.showErrorMsg(isShow: false)
                self.title = self.viewModel.getSelectedTeam()?.country
                self.countryFlagHeaderView?.teams = self.viewModel.teams
                self.playersTableView.reloadData()
            }
        }
        
        viewModel.failureBlock = { [weak self] errorMessage in
            guard let self else { return }
            DispatchQueue.main.async {
                self.showErrorMsg(text: errorMessage, isShow: true)
                self.title = self.viewModel.getSelectedTeam()?.country
            }
        }
        viewModel.fetchData()
    }
    
    private func showErrorMsg(text: String = "", isShow: Bool) {
        self.playersTableView.hideMessage()
        if isShow {
            self.playersTableView.displayMessage(text: text)
        }
    }
    
    private func setupUI() {
        searchBar.searchDelegate = self
        playersTableView.dataSource = self
        playersTableView.delegate = self
        let countryFlagCellNib = UINib(nibName: Constants.countryFlagCell,
                                       bundle: nil)
        playersTableView.register(countryFlagCellNib,
                                  forCellReuseIdentifier: Constants.countryFlagCell)
        let teamPlayerCellNib = UINib(nibName: Constants.teamPlayerCell,
                                      bundle: nil)
        playersTableView.register(teamPlayerCellNib,
                                  forCellReuseIdentifier: Constants.teamPlayerCell)
        
        countryFlagHeaderView?.autoresizingMask = .flexibleWidth
        countryFlagHeaderView?.translatesAutoresizingMaskIntoConstraints = true
        countryFlagHeaderView?.frame = CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: UIScreen.main.bounds.width * 0.52)
        playersTableView.tableHeaderView = countryFlagHeaderView
        countryFlagHeaderView?.didChangeTeam = { [weak self] index in
            guard let self else { return }
            self.searchBar.searchBarCancelButtonClicked(searchBar)
            self.viewModel.updateSelectedTeam(index: index)
            self.playersTableView.reloadData()
            self.viewModel.didSearchPlayer(text: "")
            self.title = self.viewModel.getSelectedTeam()?.country
        }
    }
    
    @IBAction func presentBottomSheet(_ sender: Any) {
        if let bottomSheetVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.bottomSheetViewController) as? BottomSheetViewController {
            bottomSheetVC.viewModel.player = viewModel.getSelectedTeam()?.players ?? []
            self.presentBottomSheet(height: 200, viewController: bottomSheetVC)
        }
    }
}

// MARK: - UITableViewDataSource Methods
extension TeamViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterTeamPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playersTableView.dequeueReusableCell(withIdentifier: Constants.teamPlayerCell, for: indexPath) as? TeamPlayerCell
        cell?.player = self.viewModel.filterTeamPlayers[indexPath.row]
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate Methods
extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchBarView = UIView()
        searchBarView.backgroundColor = UIColor.lightGreen
        searchBar.frame = CGRect(x: 17, y: 0, width: tableView.frame.width - 34, height: 40)
        searchBarView.addSubview(searchBar)
        return searchBarView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: - UISearchBarDelegate Methods
extension TeamViewController: CustomSearchBarDelegate {
    func searchBarTextDidChange(_ searchText: String) {
        showErrorMsg(text: Constants.noDataFound, isShow: false)
        viewModel.didSearchPlayer(text: searchText)
        self.playersTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked() {
        viewModel.didCancelSearch()
        showErrorMsg(isShow: false)
        playersTableView.reloadData()
    }
}
