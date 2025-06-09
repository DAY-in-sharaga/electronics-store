//
//  Message.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// Models/Message.swift
import Foundation

struct Message: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let isUser: Bool      // true, если сообщение от пользователя; false – от оператора
    let timestamp: Date
}
