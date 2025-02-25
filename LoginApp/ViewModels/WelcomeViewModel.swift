//
//  WelcomeViewModel.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

class WelcomeViewModel {
    var data: WelcomeData
    
    init(message: String) {
        self.data = WelcomeData(message: message)
    }
}
