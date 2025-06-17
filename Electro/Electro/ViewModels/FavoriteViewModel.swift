//
//  FavoriteViewModel.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// ViewModels/FavoriteViewModel.swift
import Foundation
import SwiftUI

final class FavoriteViewModel: ObservableObject {
    @Published private(set) var favorites: [Product] = []
    
    // Ключ в UserDefaults
    private let storageKey = "favorite_products"
    
    init() {
        loadFavorites()
    }
    
    /// Добавить продукт в избранное (если ещё нет)
    func add(_ product: Product) {
        guard !favorites.contains(product) else { return }
        favorites.append(product)
        saveFavorites()
    }
    
    /// Удалить продукт из избранного
    func remove(_ product: Product) {
        favorites.removeAll { $0.id == product.id }
        saveFavorites()
    }
    
    /// Проверить, в избранном ли продукт
    func contains(_ product: Product) -> Bool {
        favorites.contains(product)
    }
    
    /// Сохранить текущий список в UserDefaults
    private func saveFavorites() {
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to encode favorites: \(error)")
        }
    }
    
    /// Загрузить из UserDefaults при старте
    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            favorites = []
            return
        }
        do {
            let decoded = try JSONDecoder().decode([Product].self, from: data)
            favorites = decoded
        } catch {
            print("Failed to decode favorites: \(error)")
            favorites = []
        }
    }
}
