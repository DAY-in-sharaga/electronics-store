//
//  CheckoutView.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// Views/CheckoutView.swift
import SwiftUI

struct CheckoutView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Оформление заказа")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Text("Здесь будет форма для ввода данных: адрес, оплата и т.д.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .padding()
        .navigationTitle("Оформить заказ")
        .navigationBarTitleDisplayMode(.inline)
    }
}
