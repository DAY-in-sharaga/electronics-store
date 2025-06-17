//
//  Category.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// Models/Category.swift
import Foundation

struct Category: Identifiable, Hashable {
    let id = UUID()
    let name: String        // отображаемая строка, например "Смартфоны и гаджеты"
    let iconName: String    // имя SF Symbol или локальное имя изображения
    let filterKey: String   // ключ для фильтрации по Product.category (например "Phones")

    /// Статический набор категорий, как на третьем скриншоте
    static let sampleCategories: [Category] = [
        Category(name: "Смартфоны и гаджеты", iconName: "iphone.homebutton", filterKey: "Phones"),
        Category(name: "Ноутбуки и компьютеры", iconName: "laptopcomputer", filterKey: "Laptops"),
        Category(name: "Телевизоры и цифровое ТВ", iconName: "tv", filterKey: "TV"),
        Category(name: "Аудиотехника", iconName: "speaker.wave.2", filterKey: "Audio"),
        Category(name: "Техника для кухни", iconName: "oven", filterKey: "Kitchen"),
        Category(name: "Техника для дома", iconName: "house", filterKey: "HomeAppliances"),
        Category(name: "Красота и здоровье", iconName: "heart.text.square", filterKey: "Beauty"),
        Category(name: "Умный дом", iconName: "house.fill", filterKey: "SmartHome"),
        Category(name: "Посуда", iconName: "cup.and.saucer", filterKey: "Cookware"),
        Category(name: "Игровые приставки", iconName: "gamecontroller.fill", filterKey: "Games"),
    ]
}
