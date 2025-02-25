//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/25/25.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginDidSucceed()
    func loginDidFail(with error: String)
}

class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    
    weak var delegate: LoginViewControllerDelegate?
    
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
            self?.delegate?.loginDidSucceed()
        }
        
        viewModel.onAuthenticationFailure = { [weak self] error in
            self?.delegate?.loginDidFail(with: error)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        viewModel.login()
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
