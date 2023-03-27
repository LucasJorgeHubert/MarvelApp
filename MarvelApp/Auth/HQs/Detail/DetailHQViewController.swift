//
//  DetailHQViewController.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 26/03/23.
//

import UIKit

class DetailHQViewController: UIViewController {
    
    private let viewModel: DetailHQViewModel
    
    private let mainView = DetailHQView()
    
    init(viewModel: DetailHQViewModel) {
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
        self.navigationItem.title = "Detail"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.hidesBackButton = false
        self.mainView.buyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        setupLabels()
    }
    
    func setupLabels() {
        self.mainView.setupLabels(
            title: self.viewModel.hq?.title ?? "",
            issue: self.viewModel.hq?.issueNumber ?? 0,
            prices: self.viewModel.hq?.prices ?? []
        )
        self.mainView.setupImage(
            imageURL: self.viewModel.hq?.thumbnail ?? Thumbnail(path: "", thumbnailExtension: "")
        )
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.showSpinner(onView: self.mainView)
        self.showToast(text: "Product added in cart", type: .success, onView: self.mainView)
    }

}
