//
//  ListHQsTableViewCell.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 23/03/23.
//

import UIKit

class ListHQsTableViewCell: UITableViewCell {
        
    private let cellView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray5
        v.layer.cornerRadius = 8
        v.layer.shadowOffset = CGSize(width: 1, height: 1)
        v.layer.shadowColor = UIColor.systemGray6.cgColor
        return v
    }()
    
    private let favoriteItem: UIButton = {
       let b = UIButton()
        b.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        b.setBackgroundImage(UIImage(systemName: "star.fill"), for: .selected)
        return b
    }()
    
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.numberOfLines = 3
        return l
    }()
    
    private var idLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 1
        l.font = .systemFont(ofSize: 14, weight: .thin)
        return l
    }()
    
    private var pageLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 1
        l.font = .systemFont(ofSize: 14, weight: .thin)
        return l
    }()
    
    private var imageBehavior = UIView()

    private var image = UIImageView()

    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Custom methods
    func setup(ex: Result) {
        self.nameLabel.text = ex.title ?? ""
        self.idLabel.text = String(ex.id ?? 0)
        self.image.downloaded(from: URL(string: "\(ex.thumbnail?.path ?? "").\(ex.thumbnail?.thumbnailExtension ?? "")")!)
        self.pageLabel.text = "Pages: \(ex.pageCount ?? 0)"
        
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        imageBehavior.addSubview(image)
        [
            cellView,
            nameLabel,
            idLabel,
            imageBehavior,
            favoriteItem,
            pageLabel].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        [
            cellView,
            nameLabel,
            idLabel,
            image,
            imageBehavior,
            favoriteItem,
            pageLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            imageBehavior.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            imageBehavior.heightAnchor.constraint(equalToConstant: 128),
            imageBehavior.widthAnchor.constraint(equalToConstant: 64),
            imageBehavior.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            imageBehavior.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8),
            
            image.leadingAnchor.constraint(equalTo: imageBehavior.leadingAnchor),
            image.rightAnchor.constraint(equalTo: imageBehavior.rightAnchor),
            image.topAnchor.constraint(equalTo: imageBehavior.topAnchor),
            image.bottomAnchor.constraint(equalTo: imageBehavior.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: favoriteItem.leadingAnchor, constant: -8),
            
            favoriteItem.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16),
            favoriteItem.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            favoriteItem.widthAnchor.constraint(equalToConstant: 24),
            
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            idLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            
            pageLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8),
            pageLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16)
        ])
    }

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
