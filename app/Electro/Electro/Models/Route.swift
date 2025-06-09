//
//  Route.swift
//  Electro
//
//  Created by Adel Mansurov on 04.05.2025.
//
import SwiftUI

enum Route: Hashable {
    case account
    case register
    case login
    case main
    case favorite
    case cart
    case chat
    case chatRoom
    case detail(product: Product)
    case checkout
    case catalog           
    case categoryProducts(filterKey: String)
}
