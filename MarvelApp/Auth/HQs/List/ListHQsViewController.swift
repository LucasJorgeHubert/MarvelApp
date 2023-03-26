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
    
    private var hqs: [Result] = []
    
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
                let result = try await self.viewModel.fetchHQs()
                hqs = result.data.results
                self.mainView.hqsTable.reloadData()
                self.removeSpinner()

            } catch {
                self.removeSpinner()
                self.showToast(
                    text: "Erro ao carregar as exchanges da coinAPI.io, tente novamente mais tarde",
                    type: .error,
                    onView: self.mainView
                )
            }
        }
    }

}

extension ListHQsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.hqs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListExchangesTableViewCell", for: indexPath) as! ListHQsTableViewCell
        cell.setup(ex: self.hqs[indexPath.row])
        
        return cell
    }
    
    
}
