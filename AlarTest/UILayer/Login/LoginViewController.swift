//
//  LoginViewController.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit

// MARK: - LoginViewController
class LoginViewController: BaseViewController<LoginViewModel> {
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func setupUI() {
        super.setupUI()
        title = viewModel.title
        loginButton.layer.cornerRadius = loginButton.frame.height / 4
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    override func bindUIWithViewModel() {
        super.bindUIWithViewModel()
        viewModel.updateLoadingState = {
            [weak self] isLoading in
            
            isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            self?.loginButton.isEnabled = !isLoading
        }
    }
    
    @objc private func login() {
        viewModel.login(username: usernameTextField.text, password: passwordTextField.text)
    }
}
