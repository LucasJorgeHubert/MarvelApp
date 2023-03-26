//
//  Utils.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 22/03/23.
//

import Foundation

class Utils {
    func isAuthenticated() -> Bool {
        return UserDefaults.standard.value(forKey: "isAutenticated") as? Bool ?? false
    }
}
