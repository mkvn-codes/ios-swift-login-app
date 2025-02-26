//
//  WelcomeViewController.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import UIKit

class WelcomeViewController: UIViewController {
    private let viewModel: WelcomeViewModel
    
    @IBOutlet weak var messageLabel: UILabel!
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "WelcomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI() {
        navigationItem.hidesBackButton = true
        
        setUpMessageLabel()
        setUpLogoutBarButtonItem()
    }
    
    private func setUpMessageLabel() {
        messageLabel.text = viewModel.data.message
    }
}

//MARK: Logout functions
extension WelcomeViewController {
    private func setUpLogoutBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
    }
    
    private func showLogoutConfirmation() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            self.viewModel.logout()
        }))
        
        present(alert, animated: true)
    }
    
    @objc private func logoutButtonTapped() {
        showLogoutConfirmation()
    }
}
