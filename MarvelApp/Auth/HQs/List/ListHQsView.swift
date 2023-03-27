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
    
    var searchHQs = UISearchBar()
    
    let nextPageButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.right.square"), for: .normal)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.isEnabled = true
        return btn
    }()
    
    let previusPageButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.backward.square"), for: .normal)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.isEnabled = true
        return btn
    }()
    
    var currentPage: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        return l
    }()
    
    var pageControlStackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.axis = .horizontal
        sv.backgroundColor = .black
        sv.layer.cornerRadius = 8
        return sv
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
        addSubview(searchHQs)
        addSubview(pageControlStackView)
        
        pageControlStackView.addArrangedSubview(previusPageButton)
        pageControlStackView.addArrangedSubview(currentPage)
        pageControlStackView.addArrangedSubview(nextPageButton)
    }
    
    private func setupConstraints() {
        [
            hqsTable,
            searchHQs,
            pageControlStackView,
            previusPageButton,
            currentPage,
            nextPageButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            searchHQs.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchHQs.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchHQs.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            hqsTable.topAnchor.constraint(equalTo: searchHQs.bottomAnchor, constant: 16),
            hqsTable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            hqsTable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hqsTable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            pageControlStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            pageControlStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            pageControlStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            pageControlStackView.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
