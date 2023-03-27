//
//  DetailHQViewModel.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 26/03/23.
//

import Foundation

class DetailHQViewModel {
    let coordinator: MainCoordinator?
    let hq: HQ?
    
    init(coordinator: MainCoordinator, hq: HQ) {
        self.coordinator = coordinator
        self.hq = hq
    }
    
    func buyItem()  {
        if Utils().isAuthenticated() {
            self.coordinator?.cartManager.addItem(item: hq!)
        }
    }
}
