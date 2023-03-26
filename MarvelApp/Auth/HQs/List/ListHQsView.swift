//
//  ListHQsView.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 23/03/23.
//

import UIKit

class ListHQsView: UIView {
    var hqsTable: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        return tv
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        addSubview(hqsTable)
    }
    
    private func setupConstraints() {
        hqsTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            hqsTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            hqsTable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            hqsTable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hqsTable.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}
