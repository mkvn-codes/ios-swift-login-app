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
    
    private let dependencies = AppDependencies.shared
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        dependencies.sessionManager.delegate = self
        
        navigateToLoginScreen()
    }
    
    private func navigateToLoginScreen() {
        let authService = SampleAuthenticationService()
        let loginViewModel = LoginViewModel(authService: authService)
        let loginVC = LoginViewController(viewModel: loginViewModel)
        
        loginVC.delegate = self

        let newNavController = UINavigationController(rootViewController: loginVC)
        window.rootViewController = newNavController
        window.makeKeyAndVisible()

        navigationController = newNavController
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

extension AppCoordinator: SessionManagerDelegate {
    func sessionDidStart(user: SessionUser) {
        navigateToWelcomeScreen()
    }
    
    func sessionDidEnd() {
        navigateToLoginScreen()
    }
}
