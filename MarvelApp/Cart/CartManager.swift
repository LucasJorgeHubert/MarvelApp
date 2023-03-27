//
//  CartManager.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 26/03/23.
//

import Foundation

class CartManager {
    private var itemsInCart: [HQ] = []
    
    func addItem(item: HQ) {
        itemsInCart.append(item)
    }
    
    func removeItem(id: Int) {
        let item = itemsInCart.firstIndex { $0.id == id }
    }
    
    func getAllItems() -> [HQ] {
        return itemsInCart
    }
    
    func sumAllItems() -> Double {
        var sumedItems = 0.0
        itemsInCart.forEach { sumedItems += sumPrices(prices: $0.prices ?? [Price(type: "", price: 0.0)]) }
        return sumedItems
    }
    
    private func sumPrices(prices: [Price]) -> Double {
        var price = 0.0
        prices.forEach { price += $0.price ?? 0.0 }
        return price
    }
}
