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
    
    private func navigateToWelcomeScreen() {
        let welcomeViewModel = WelcomeViewModel(message: "Welcome")
        let welcomeVC = WelcomeViewController(viewModel: welcomeViewModel)
        navigate(to: welcomeVC)
    }
    
    private func navigate(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension AppCoordinator: LoginViewControllerDelegate {
    func loginDidSucceed() {
        navigateToWelcomeScreen()
    }
    
    func loginDidFail(with error: String) {
        print(#function)
    }
}
