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
        if let username = usernameTextField.text {
            viewModel.username = username
        }
        
        if let password = passwordTextField.text {
            viewModel.password = password
        }
    }
    
    @objc private func textFieldChanged(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        if textField == usernameTextField {
            viewModel.username = text
        }
        else if textField == passwordTextField {
            viewModel.password = text
        }
    }
}
