//
//  DetailHQView.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 26/03/23.
//

import UIKit

enum PriceType : String {
    case printPrice
    case digitalPurchasePrice
}

class DetailHQView: UIView {
    
    private let scrollView = UIScrollView()

    private let imageBehavior = UIView()
    private var imageCover = UIImageView()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.numberOfLines = 3
        return l
    }()
    
    private let issueLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .thin)
        l.numberOfLines = 3
        return l
    }()
    
    private let priceLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .regular)
        l.numberOfLines = 3
        return l
    }()
    
    let buyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Buy", for: .normal)
        btn.setImage(UIImage(systemName: "cart.fill.badge.plus"), for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.isEnabled = true
        return btn
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
    
    func setupLabels(title: String, issue: Int, prices: [Price]) {
        self.titleLabel.text = title
        self.issueLabel.text = "Issue #\(issue)"
        self.priceLabel.text = getPrice(prices: prices)
    }
    
    func setupImage(imageURL: Thumbnail) {
        self.imageCover.downloaded(from: "\(imageURL.path ?? "").\(imageURL.thumbnailExtension ?? "")")
    }
    
    func getPrice(prices: [Price]) -> String {
        var priceString = ""
        for i in prices {
            
            priceString.append(String(format: "\(getPriceType(i.type ?? "")): $ %.02f \n", i.price ?? 0.0))
        }
        return priceString
    }
    
    func getPriceType(_ priceType: String) -> String{
        var type = PriceType(rawValue: priceType)
        switch type {
        case .printPrice:
            return "Printed"
        case .digitalPurchasePrice:
            return "Digital"
        case .none:
            return ""
        }
    }
    
    private func buildViewHierarchy() {
        addSubview(scrollView)
        imageBehavior.addSubview(imageCover)
        [
            imageBehavior,
            titleLabel,
            issueLabel,
            priceLabel,
            buyButton
        ].forEach { scrollView.addSubview($0) }
    }
    
    private func setupConstraints() {
        [
            scrollView,
            imageBehavior,
            imageCover,
            titleLabel,
            issueLabel,
            priceLabel,
            buyButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            
            imageBehavior.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            imageBehavior.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageBehavior.heightAnchor.constraint(equalToConstant: 128),
            imageBehavior.widthAnchor.constraint(equalToConstant: 64),
            
            imageCover.leadingAnchor.constraint(equalTo: imageBehavior.leadingAnchor),
            imageCover.trailingAnchor.constraint(equalTo: imageBehavior.trailingAnchor),
            imageCover.topAnchor.constraint(equalTo: imageBehavior.topAnchor),
            imageCover.bottomAnchor.constraint(equalTo: imageBehavior.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageBehavior.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: imageBehavior.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            issueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            issueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            issueLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: issueLabel.bottomAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            buyButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            buyButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            buyButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    

}
