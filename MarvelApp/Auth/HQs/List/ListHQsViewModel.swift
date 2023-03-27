//
//  ListHQsViewModel.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 23/03/23.
//

import Foundation

enum FavoriteListActions {
    case add
    case remove
}

public class ListHQsViewModel {
    
    let coordinator: MainCoordinator?
    
    let favoriteKey = "favoriteHQs"
    
    var limit = 10
    var offset = 0
    var searchedHQs: [HQ] = []
    var searching = false
    var hqs: [HQ] = []
    
    var favoriteHQs: [Int] = []
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func getHQs() -> [HQ] {
        if searching {
            return self.searchedHQs
        } else {
            return self.hqs
        }
    }
    
    func fetchFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: favoriteKey) as! [Int]
    }
    
    func updateFavorites(indexPath: IndexPath, action: FavoriteListActions) {
        switch action {
        case .add:
            favoriteHQs.append(getHQs()[indexPath.row].id ?? 0)
        case .remove:
            let index = favoriteHQs.firstIndex { $0 == getHQs()[indexPath.row].id ?? 0 }
            if let i = index {
                favoriteHQs.remove(at: i)
            }
        }
        UserDefaults.standard.set(favoriteHQs, forKey: favoriteKey)
    }
    
    func isFavorited(indexPath: IndexPath) -> Bool {
        let hqId = getHQs()[indexPath.row].id
        return favoriteHQs.contains { $0 == hqId }
    }
    
    func itemIsInCart(indexPath: IndexPath) -> Bool {
        return self.coordinator?.cartManager.itemIsInCart(hq: getHQs()[indexPath.row]) ?? false
    }
    
    func openDetail(indexPath: IndexPath) {
        self.coordinator?.openHQDetail(hq: self.getHQs()[indexPath.row])
    }
    
    func addToCart(indexPath: IndexPath) {
        self.coordinator?.cartManager.addItem(item: getHQs()[indexPath.row])
    }
    
    func removeFromCart(indexPath: IndexPath) {
        self.coordinator?.cartManager.removeItem(id: getHQs()[indexPath.row].id ?? 0)
    }
    
    func nextPage() {
        offset += 10
        limit += 10
    }
    
    func previusPage() {
        if offset > 0 {
            offset -= 10
            limit -= 10
        }
    }
    
    func fetchHQs() async throws {
        let keys = KeysManager().apiKey
        var request = URLRequest(
            url: URL(
                string: "https://gateway.marvel.com/v1/public/comics?format=digital%20comic&limit=\(limit)&offset=\(offset)&ts=1&apikey=\(keys.0)&hash=\(keys.1)"
            )!
        )
        
        request.httpMethod = "GET"
        
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil {
                        continuation.resume(with: .failure(error!))
                    } else if let data = data {
                        do {
                            self.hqs = []
                            let list: HQs = try JSONDecoder().decode(HQs.self, from: data)
                            self.hqs = list.data.results
                            continuation.resume()
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
