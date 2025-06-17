import SwiftUI

struct CategoryProductsView: View {
    let filterKey: String
    @StateObject private var allProductsVM = ProductListViewModel()
    @EnvironmentObject private var navigationVM: NavigationViewModel

    // Источник — либо данные с сервера, либо sampleApple, если сервер пустой
    private var sourceProducts: [Product] {
        allProductsVM.products.isEmpty
            ? Product.sampleApple
            : allProductsVM.products
    }

    private var filteredProducts: [Product] {
        sourceProducts.filter { $0.category == filterKey }
    }

    private let columns = [
        GridItem(.flexible()), GridItem(.flexible())
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Товары: \(filterKey)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)

            if filteredProducts.isEmpty {
                // Показать спиннер или сообщение, если ничго не найдено
                ProgressView("Загрузка…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredProducts) { product in
                            NavigationLink(value: Route.detail(product: product)) {
                                ProductCellView(product: product)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top)
        .navigationTitle(filterKey)
        .navigationBarTitleDisplayMode(.inline)
        // На всякий случай ещё раз вызываем загрузку при появлении
        .task {
            await allProductsVM.loadProducts()
        }
    }
}
