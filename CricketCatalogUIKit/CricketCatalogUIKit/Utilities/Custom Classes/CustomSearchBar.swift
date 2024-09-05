//
//  CustomSearchBar.swift
//  CricketCatalogUIKit
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import UIKit

protocol CustomSearchBarDelegate {
    func searchBarTextDidChange(_ searchText: String)
    func searchBarCancelButtonClicked()
}

class CustomSearchBar: UISearchBar {
   
    var searchDelegate: CustomSearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        self.placeholder = "Search Player"
        self.barTintColor = .lightGreen
        self.searchBarStyle = .minimal
        self.delegate = self
        self.showsCancelButton = false
        self.sizeToFit()
        self.searchTextField.clearButtonMode = .never
    }
}

extension CustomSearchBar : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = !searchText.isEmpty
        searchDelegate?.searchBarTextDidChange(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchDelegate?.searchBarCancelButtonClicked()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

