//
//  ListHQsViewController+SearchBar.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 27/03/23.
//

import Foundation
import UIKit

extension ListHQsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchedHQs = self.viewModel.getHQs().filter { $0.title?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased() }
        self.viewModel.searching = true
        self.mainView.hqsTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.searching = false
        searchBar.text = ""
        self.mainView.hqsTable.reloadData()
    }
}
