//
//  ListHQsViewModel.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 23/03/23.
//

import Foundation

public class ListHQsViewModel {
    
    let coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchHQs() async throws -> (HQs) {
        let keys = KeysManager().apiKey
        var request = URLRequest(url: URL(string: "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=\(keys.0)&hash=\(keys.1)")!)
        
        request.httpMethod = "GET"
        
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil {
                        continuation.resume(with: .failure(error!))
                    } else if let data = data {
                        do {
                            let list: HQs = try JSONDecoder().decode(HQs.self, from: data)
                            continuation.resume(with: .success(list))
                        } catch {
                            print(String(describing: error))
                            continuation.resume(with: .failure(error))
                        }
                    }
                }
            }.resume()
        }
    }
}
