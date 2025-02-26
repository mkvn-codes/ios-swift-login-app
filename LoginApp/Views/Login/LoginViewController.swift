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
    
    @IBOutlet weak var loginButton: UIButton!
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
        
        bindViewModel()
        
        setUpTextField()
        updateLoginButtonState()
        updateCredentialsFromTextFieldValues()
        
        setUpKeyboardDismissGesture()
        setUpKeyboardObservers()
    }
    
    private func bindViewModel() {
        viewModel.onAuthenticationSuccess = { [weak self] in
            self?.hideLoading()
        }
        
        viewModel.onAuthenticationFailure = { [weak self] errorMessage in
            self?.hideLoading()
            self?.showToast(message: errorMessage)
        }
        
        viewModel.onCredentialsUpdate = { [weak self] in
            self?.updateLoginButtonState()
        }
    }
    
    private func login() {
        showLoading()
        
        viewModel.login()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        login()
    }
}

//MARK: Toast
extension LoginViewController {
    // We can make this a ToastManager and add to AppDependencies instead
    private func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: 20, y: view.frame.height - 100, width: view.frame.width - 40, height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        toastLabel.text = message
        toastLabel.alpha = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}

//MARK: Activity Indicator
extension LoginViewController {
    // We can make this a LoadingOverlayManager and add to AppDependencies instead
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

//MARK: Login Button
extension LoginViewController {
    private func updateLoginButtonState() {
        let isValid = viewModel.hasValidCredentials
        
        self.loginButton.isEnabled = isValid
        self.loginButton.alpha = isValid ? 1.0 : 0.6
    }
}

//MARK: Text Field functions
extension LoginViewController {
    private func setUpTextField() {
        usernameTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
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

//MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        loginButtonPressed(loginButton)
        return true
    }
}

//MARK: Keyboard
extension LoginViewController {
    private func setUpKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setUpKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            view.frame.origin.y = -keyboardHeight/2
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
}
