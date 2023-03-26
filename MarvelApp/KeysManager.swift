//
//  KeysManager.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 22/03/23.
//

import Foundation

class KeysManager {
    var apiKey: (String, String) {
        get {
            guard let path = Bundle.main.path(forResource: "MarvelKeys", ofType: "plist") else { return ("", "") }
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String:String]
            return (plist?["MarvelApiPublicKey"] ?? "", plist?["MarvelMD5Hash"] ?? "")
        }
    }
}
