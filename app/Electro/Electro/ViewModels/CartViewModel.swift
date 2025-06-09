//
//  CartViewModel.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// ViewModels/CartViewModel.swift
import Foundation
import SwiftUI

final class CartViewModel: ObservableObject {
    @Published private(set) var items: [CartItem] = []
    
    private let storageKey = "cart_items"
    
    init() {
        loadCart()
    }
    
    /// Добавить продукт в корзину: если уже есть — увеличить quantity, иначе добавить как новый элемент
    func add(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            let newItem = CartItem(product: product, quantity: 1, isSelected: true)
            items.append(newItem)
        }
        saveCart()
    }
    
    /// Удалить элемент полностью из корзины
    func remove(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
        saveCart()
    }
    
    /// Установить выбранный/не выбранный флаг (для подсчёта итоговой суммы)
    func toggleSelection(for item: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].isSelected.toggle()
        saveCart()
    }
    
    /// Обновить количество (quantity) для позиции
    func updateQuantity(for item: CartItem, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].quantity = max(1, quantity)
        saveCart()
    }
    
    /// Выбрать все элементы (или снять выбор)
    func selectAll(_ select: Bool) {
        for idx in items.indices {
            items[idx].isSelected = select
        }
        saveCart()
    }
    
    /// Удалить все выбранные элементы
    func removeSelected() {
        items.removeAll { $0.isSelected }
        saveCart()
    }
    
    /// Итоговая сумма по выбранным позициям
    var totalPrice: Double {
        items.filter { $0.isSelected }.reduce(0) { $0 + $1.totalPrice }
    }
    
    /// Сохранить корзину в UserDefaults
    private func saveCart() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to encode cart items: \(error)")
        }
    }
    
    /// Загрузить корзину при старте
    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            items = []
            return
        }
        do {
            let decoded = try JSONDecoder().decode([CartItem].self, from: data)
            items = decoded
        } catch {
            print("Failed to decode cart items: \(error)")
            items = []
        }
    }
}
