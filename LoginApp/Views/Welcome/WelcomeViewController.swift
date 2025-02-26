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
    }
    
    private func setUpMessageLabel() {
        messageLabel.text = viewModel.data.message
    }

}
