//
//  ListHQsViewController.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 23/03/23.
//

import UIKit

class ListHQsViewController: UIViewController {
    
    let viewModel: ListHQsViewModel
    
    let mainView = ListHQsView()
    
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
        
        self.mainView.searchHQs.showsCancelButton = true
        self.mainView.searchHQs.delegate = self

        setupTable()
        setupTableData()
        setupNavigationItem()
    }
    
    func setupNavigationItem() {
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(
                    systemName: self.viewModel.coordinator?.cartManager.hasItemsInCart() ?? false ? "cart.fill" : "cart"
                ), style: .done,
                target: self,
                action: #selector(openCart))
        ]
    }
    
    private func setupTable() {
        mainView.hqsTable.dataSource = self
        mainView.hqsTable.delegate = self
        mainView.hqsTable.register(ListHQsTableViewCell.self, forCellReuseIdentifier: "ListExchangesTableViewCell")
    }
    
    @objc private func openCart() {
        /// TODO: open cart
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
