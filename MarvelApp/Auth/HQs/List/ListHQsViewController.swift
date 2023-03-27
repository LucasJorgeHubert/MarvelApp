//
//  ListHQsViewController.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 23/03/23.
//

import UIKit

class ListHQsViewController: UIViewController {
    
    private let viewModel: ListHQsViewModel
    
    private let mainView = ListHQsView()
    
    init(viewModel: ListHQsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "HQ's"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.hidesBackButton = true
        setupTable()
        setupTableData()
    }
    
    private func setupTable() {
        mainView.hqsTable.dataSource = self
        mainView.hqsTable.delegate = self
        mainView.hqsTable.register(ListHQsTableViewCell.self, forCellReuseIdentifier: "ListExchangesTableViewCell")
    }
    
    private func setupTableData() {
        self.showSpinner(onView: self.mainView)
        Task.init {
            do {
                try await self.viewModel.fetchHQs()
                self.mainView.hqsTable.reloadData()
                self.removeSpinner()
            } catch {
                self.removeSpinner()
                self.showToast(
                    text: "Erro ao carregar as HQs, tente novamente mais tarde",
                    type: .error,
                    onView: self.mainView
                )
            }
        }
    }

}

extension ListHQsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.hqs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListExchangesTableViewCell", for: indexPath) as! ListHQsTableViewCell
        cell.setup(ex: self.viewModel.hqs[indexPath.row], isFavorited: self.viewModel.isFavorited(indexPath: indexPath))
        
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
        
        let addToCart = UIContextualAction(style: .normal, title: "Add to cart") {  (contextualAction, view, boolValue) in
            self.viewModel.addToCart(indexPath: indexPath)
            self.mainView.hqsTable.reloadData()
        }
        addToCart.image = UIImage(systemName: "cart.fill.badge.plus")
        addToCart.backgroundColor = .systemBlue
        
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem, addToCart])

        return swipeActions
    }
}
