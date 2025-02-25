//
//  AppCoordinator.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/25/25.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator : Coordinator {
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let authService = SampleAuthenticationService()
        let loginViewModel = LoginViewModel(authService: authService)
        let loginVC = LoginViewController(viewModel: loginViewModel)
        
        loginVC.delegate = self
        
        navigationController = UINavigationController(rootViewController: loginVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: LoginViewControllerDelegate {
    func loginDidSucceed() {
        print(#function)
    }
    
    func loginDidFail(with error: String) {
        print(#function)
    }
}
