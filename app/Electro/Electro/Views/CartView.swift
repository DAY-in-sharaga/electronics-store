//
//  CartView.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// Views/CartView.swift
import SwiftUI

struct CartView: View {
    @EnvironmentObject private var cartVM: CartViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    // Для «Выбрать всё»
    @State private var selectAllToggle: Bool = false
    
    var body: some View {
        VStack {
            if cartVM.items.isEmpty {
                // Пустая корзина
                Spacer()
                VStack(spacing: 16) {
                    Text("В корзине пока ничего нет")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Button("Посмотреть каталог") {
                        navigationVM.navigate(to: .main)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                Spacer()
            } else {
                // Содержимое корзины
                VStack(spacing: 0) {
                    // 1. Выбрать все / Удалить выбранные
                    HStack {
                        Button(action: {
                            selectAllToggle.toggle()
                            cartVM.selectAll(selectAllToggle)
                        }) {
                            HStack {
                                Image(systemName: selectAllToggle ? "checkmark.square.fill" : "square")
                                Text("Выбрать всё")
                            }
                        }
                        .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button("Удалить выбранные") {
                            cartVM.removeSelected()
                        }
                        .foregroundColor(.red)
                    }
                    .padding()
                    
                    Divider()
                    
                    // 2. Список позиций
                    List {
                        ForEach(cartVM.items) { item in
                            HStack(spacing: 16) {
                                // Чекбокс выбора
                                Button(action: {
                                    cartVM.toggleSelection(for: item)
                                }) {
                                    Image(systemName: item.isSelected ? "checkmark.square.fill" : "square")
                                        .foregroundColor(item.isSelected ? .blue : .gray)
                                }
                                
                                // Изображение товара
                                AsyncImage(url: item.product.imageUrl) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 60, height: 60)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(item.product.name)
                                        .font(.headline)
                                    Text(item.product.priceString)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    // Ползунок для изменения количества
                                    HStack {
                                        Button(action: {
                                            let newQty = max(1, item.quantity - 1)
                                            cartVM.updateQuantity(for: item, quantity: newQty)
                                        }) {
                                            Image(systemName: "minus.circle")
                                        }
                                        Text("\(item.quantity)")
                                            .frame(minWidth: 24)
                                        Button(action: {
                                            cartVM.updateQuantity(for: item, quantity: item.quantity + 1)
                                        }) {
                                            Image(systemName: "plus.circle")
                                        }
                                    }
                                    .font(.title3)
                                    .foregroundColor(.blue)
                                }
                                
                                Spacer()
                                
                                // Иконка «еще» (можно убрать или оставить)
                                Image(systemName: "ellipsis")
                                    .rotationEffect(.degrees(90))
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { idx in
                                let item = cartVM.items[idx]
                                cartVM.remove(item)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    // 3. Детали заказа: итоговая сумма и кнопка «Оформить»
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Детали заказа")
                                    .font(.headline)
                                Text("\(cartVM.items.filter { $0.isSelected }.count) товар(а)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(cartVM.totalPrice, specifier: "%.2f") ₽")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("\(cartVM.items.filter { $0.isSelected }.reduce(0) { $0 + $1.totalPrice }, specifier: "%.2f") ₽")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                    .strikethrough(cartVM.items.filter { $0.isSelected }.reduce(0) { $0 + $1.totalPrice } > cartVM.totalPrice)
                                    // В данном примере скидок нет, поэтому вторую цену можно убрать
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        
                        Button(action: {
                            navigationVM.navigate(to: .checkout)
                        }) {
                            Text("Оформить")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                    .background(Color(.systemBackground).shadow(radius: 2))
                }
            }
        }
        .navigationTitle("Корзина")
        .navigationBarTitleDisplayMode(.inline)
    }
}
