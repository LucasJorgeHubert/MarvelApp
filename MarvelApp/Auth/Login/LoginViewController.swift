//
//  LoginViewController.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 22/03/23.
//

import UIKit

class LoginViewController: UIViewController {

    private let viewModel: LoginViewModel
    
    private let mainView = LoginView()
    
    init(viewModel: LoginViewModel) {
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
        self.navigationItem.title = "Login"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.hidesBackButton = true
        self.mainView.loginButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.showSpinner(onView: self.mainView)
        viewModel.openApp()
        self.removeSpinner()
    }

}
