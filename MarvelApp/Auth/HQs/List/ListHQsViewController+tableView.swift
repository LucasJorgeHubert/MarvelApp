//
//  ListHQsViewController+tableView.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 26/03/23.
//

import Foundation
import UIKit

extension ListHQsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getHQs().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListExchangesTableViewCell", for: indexPath) as! ListHQsTableViewCell
        cell.setup(ex: self.viewModel.getHQs()[indexPath.row], isFavorited: self.viewModel.isFavorited(indexPath: indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.openDetail(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var contextItem: UIContextualAction
        if self.viewModel.isFavorited(indexPath: indexPath) {
            contextItem = UIContextualAction(style: .destructive, title: "Unfavorite") {  (contextualAction, view, boolValue) in
                let controller = UIAlertController(title: "Confirm remove", message: "This action cannot be undone", preferredStyle: .actionSheet)

                DispatchQueue.global(qos: .userInitiated).async {
                    let okAction = UIAlertAction(title: "I confirm", style: .destructive) { (handler) in
                        self.viewModel.updateFavorites(indexPath: indexPath, action: .remove)
                        self.mainView.hqsTable.reloadData()
                    }
                        
                    let cancelAction = UIAlertAction(title: "No! Cancel please", style: .default) { _ in }
                        
                    DispatchQueue.main.async {
                        controller.addAction(okAction)
                        controller.addAction(cancelAction)
                        self.present(controller, animated: true, completion: nil)
                    }
                }
            }
            
            contextItem.image = UIImage(systemName: "star.slash")
            contextItem.backgroundColor = .systemRed
        } else {
            contextItem = UIContextualAction(style: .normal, title: "Favorite") {  (contextualAction, view, boolValue) in
                self.viewModel.updateFavorites(indexPath: indexPath, action: .add)
                self.mainView.hqsTable.reloadData()
            }
            contextItem.image = UIImage(systemName: "star")
            contextItem.backgroundColor = .systemGreen
        }
        
        var addToCart: UIContextualAction
        if self.viewModel.itemIsInCart(indexPath: indexPath) {
            addToCart = UIContextualAction(style: .normal, title: "Remove from cart") {  (contextualAction, view, boolValue) in
                let controller = UIAlertController(title: "Confirm remove", message: "This action cannot be undone", preferredStyle: .actionSheet)
                
                DispatchQueue.global(qos: .userInitiated).async {
                    let okAction = UIAlertAction(title: "Remove from cart", style: .destructive) { (handler) in
                        self.viewModel.removeFromCart(indexPath: indexPath)
                        self.mainView.hqsTable.reloadData()
                        self.setupNavigationItem()
                    }
                        
                    let cancelAction = UIAlertAction(title: "No! Cancel please", style: .default) { _ in }
                        
                    DispatchQueue.main.async {
                        controller.addAction(okAction)
                        controller.addAction(cancelAction)
                        self.present(controller, animated: true, completion: nil)
                    }
                }
            }
            addToCart.image = UIImage(systemName: "cart.badge.minus")
            addToCart.backgroundColor = .systemRed
        } else {
            addToCart = UIContextualAction(style: .normal, title: "Add to cart") {  (contextualAction, view, boolValue) in
                self.viewModel.addToCart(indexPath: indexPath)
                self.showToast(text: "Item added to cart", type: .success, onView: self.mainView)
                self.mainView.hqsTable.reloadData()
                self.setupNavigationItem()
            }
            addToCart.image = UIImage(systemName: "cart.fill.badge.plus")
            addToCart.backgroundColor = .systemBlue
        }
        
        
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem, addToCart])

        return swipeActions
    }
}
