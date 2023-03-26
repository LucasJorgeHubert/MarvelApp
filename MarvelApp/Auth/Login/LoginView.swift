//
//  LoginView.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 22/03/23.
//

import UIKit

class LoginView: UIView {
    
    var scrollView = UIScrollView()
    
    let loginLabel: UILabel = {
        let l = UILabel()
        l.text = "Email"
        return l
    }()
    
    let passLabel: UILabel = {
        let l = UILabel()
        l.text = "Password"
        return l
    }()
    
    let loginField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .emailAddress
        tf.isUserInteractionEnabled = true
        tf.placeholder = "prson@mail.com"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .systemGray6
        return tf
    }()
    
    let passField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .default
        tf.isSecureTextEntry = true
        tf.isUserInteractionEnabled = true
        tf.placeholder = "******"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .systemGray6
        return tf
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = .systemRed
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
    
    func buildViewHierarchy() {
        [
        loginLabel,
        passLabel,
        loginField,
        passField,
        loginButton
        ].forEach { scrollView.addSubview($0) }
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        [
        scrollView,
        loginLabel,
        passLabel,
        loginField,
        passField,
        loginButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            loginLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            loginLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            loginLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            loginField.topAnchor.constraint(equalTo: loginLabel.topAnchor, constant: 24),
            loginField.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            loginField.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            passLabel.topAnchor.constraint(equalTo: loginField.topAnchor, constant: 48),
            passLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            passLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            passField.topAnchor.constraint(equalTo: passLabel.topAnchor, constant: 24),
            passField.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            passField.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            loginButton.topAnchor.constraint(equalTo: passField.topAnchor, constant: 48),
            loginButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            loginButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
        ])
    }
}
