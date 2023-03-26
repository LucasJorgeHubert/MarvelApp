//
//  LoginViewModel.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 22/03/23.
//

import Foundation

class LoginViewModel {
    let coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func doLogin()  {
        UserDefaults.standard.set(true, forKey: "isAutenticated")
    }
    
    func openApp()  {
        doLogin()
        if Utils().isAuthenticated() {
            coordinator?.openApp()
        }
    }
    
}
