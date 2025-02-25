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
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        navigationController = UINavigationController(rootViewController: loginVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
