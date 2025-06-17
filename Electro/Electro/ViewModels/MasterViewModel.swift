//
//  MasterViewModel.swift
//  Electro
//
//  Created by Adel Mansurov on 20.05.2025.
//

//import SwiftUI
//
///// Данные для MasterView
//final class MasterViewModel: ObservableObject {
//    @Published var searchText = ""
//    @Published var selectedCity = "Казань"
//    let todayProducts = Product.sampleApple
//    let recommendedProducts = Product.sampleApple
//    let saleProducts = Product.sampleApple
//}
import SwiftUI

/// Данные для MasterView с поддержкой поиска по товарам
final class MasterViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedCity = "Казань"
    
    /// Источник всех товаров для поиска
    let allProducts: [Product] = Product.sampleApple
    
    /// Отфильтрованные товары на основе searchText
    var filteredProducts: [Product] {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return [] }
        return allProducts.filter {
            $0.name.localizedCaseInsensitiveContains(trimmed)
        }
    }
    
    /// Секции (без фильтрации)
    var todayProducts: [Product] { allProducts }
    var recommendedProducts: [Product] { allProducts }
    var saleProducts: [Product] { allProducts }
}
