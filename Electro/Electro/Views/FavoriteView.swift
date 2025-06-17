// Views/FavoriteView.swift
import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject private var favoriteVM: FavoriteViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    var body: some View {
        VStack {
            if favoriteVM.favorites.isEmpty {
                // Пустое состояние
                Spacer()
                VStack(spacing: 16) {
                    Text("В избранном пока ничего нет")
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
                // Список избранных
                List {
                    ForEach(favoriteVM.favorites) { product in
                        // Каждая строка — NavigationLink к деталям
                        NavigationLink(value: Route.detail(product: product)) {
                            HStack(spacing: 16) {
                                AsyncImage(url: product.imageUrl) { phase in
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
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.name)
                                        .font(.headline)
                                    Text(product.priceString)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                // Кнопка «Удалить из избранного»
                                Button(action: {
                                    favoriteVM.remove(product)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { idx in
                            let product = favoriteVM.favorites[idx]
                            favoriteVM.remove(product)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Избранное")
        .navigationBarTitleDisplayMode(.inline)
    }
}

