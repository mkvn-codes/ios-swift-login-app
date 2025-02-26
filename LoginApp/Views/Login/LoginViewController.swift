//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/25/25.
//

import UIKit

class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    
    private var loadingOverlay: UIView?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextField()
        updateCredentialsFromTextFieldValues()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.onAuthenticationSuccess = { [weak self] in
            self?.hideLoading()
        }
        
        viewModel.onAuthenticationFailure = { [weak self] error in
            self?.hideLoading()
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        showLoading()
        
        viewModel.login()
    }
}

//MARK: Activity Indicator
extension LoginViewController {
    private func showLoading() {
        guard loadingOverlay == nil else {
            return
        }
        
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = overlay.center
        activityIndicator.startAnimating()
        
        overlay.addSubview(activityIndicator)
        view.addSubview(overlay)
        
        loadingOverlay = overlay
    }
    
    private func hideLoading() {
        loadingOverlay?.removeFromSuperview()
        loadingOverlay = nil
    }
}

//MARK: Text Field functions
extension LoginViewController {
    private func setUpTextField() {
        usernameTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
    }
    
    private func updateCredentialsFromTextFieldValues() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.updateCredentials(username: username, password: password)
    }
    
    @objc private func textFieldChanged(_ textField: UITextField) {
        updateCredentialsFromTextFieldValues()
    }
}
