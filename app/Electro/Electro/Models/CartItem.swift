//
//  CartItem.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// Models/CartItem.swift
import Foundation

struct CartItem: Identifiable, Codable {
    var id: Int { product.id }
    let product: Product
    var quantity: Int
    var isSelected: Bool
    
    // Для подсчёта цены одной позиции (кол-во * цена продукта)
    var totalPrice: Double {
        return Double(quantity) * product.price
    }
}
