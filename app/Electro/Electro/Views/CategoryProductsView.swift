//
//  CategoryProductsView.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// Views/CategoryProductsView.swift
import SwiftUI

struct CategoryProductsView: View {
    let filterKey: String              // например "Phones"
    @StateObject private var allProductsVM = ProductListViewModel()
    @EnvironmentObject private var navigationVM: NavigationViewModel

    private var filteredProducts: [Product] {
        allProductsVM.products.filter { $0.category == filterKey }
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
        .padding(.top)
        .navigationTitle("\(filterKey)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoryProductsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CategoryProductsView(filterKey: "Phones")
                .environmentObject(NavigationViewModel())
        }
    }
}
