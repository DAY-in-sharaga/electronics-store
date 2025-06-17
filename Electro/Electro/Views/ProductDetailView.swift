import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @State private var rating: Int = Int.random(in: 4...5)
    
    @EnvironmentObject private var favoriteVM: FavoriteViewModel
    @EnvironmentObject private var cartVM: CartViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 1. Изображение
                AsyncImage(url: product.imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                    @unknown default:
                        EmptyView()
                    }
                }
                .background(Color(.systemGray6))

                // 2. Название и цена
                Text(product.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                Text(product.priceString)
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                // 3. Кнопки «В корзину» и «В избранное»
                HStack(spacing: 24) {
                    Button(action: {
                        cartVM.add(product)
                    }) {
                        HStack {
                            Image(systemName: "cart.badge.plus")
                            Text("В корзину")
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                        .foregroundColor(.white)
                    }

                    // Избранное: меняем иконку в зависимости от наличия
                    Button(action: {
                        if favoriteVM.contains(product) {
                            favoriteVM.remove(product)
                        } else {
                            favoriteVM.add(product)
                        }
                    }) {
                        HStack {
                            Image(systemName: favoriteVM.contains(product) ? "heart.fill" : "heart")
                            Text(favoriteVM.contains(product) ? "Убрать" : "В избранное")
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(RoundedRectangle(cornerRadius: 8).fill(favoriteVM.contains(product) ? Color.gray : Color.red))
                        .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)

                // 4. Описание товара
                Text("Описание:")
                    .font(.headline)
                    .padding(.horizontal)
                Text(product.description)
                    .padding(.horizontal)

                // 5. Рейтинг в звёздах
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        if index < rating {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.gray)
                        }
                    }
                    Text("(\(rating).0)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                Spacer(minLength: 30)
            }
            .padding(.top)
        }
        .navigationTitle("Детали товара")
        .navigationBarTitleDisplayMode(.inline)
    }
}

