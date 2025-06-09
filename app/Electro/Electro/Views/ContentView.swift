// Views/ContentView.swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel

    var body: some View {
        NavigationStack(path: $navigationVM.path) {
            MasterView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .account:
                        EntrySelectionView()
                    case .register:
                        RegisterView()
                    case .login:
                        LoginView()
                    case .main:
                        CatalogView()
                    case .favorite:
                        FavoriteView()
                    case .cart:
                        CartView()
                    case .chat:
                        ChatOptionsView()
                    case .chatRoom:
                        ChatRoomView()
                    case .detail(let product):
                        ProductDetailView(product: product)
                    case .checkout:
                        CheckoutView()
                    case .catalog:
                        CatalogView()
                    case .categoryProducts(let filterKey):
                        CategoryProductsView(filterKey: filterKey)
                    }
                }
        }
    }
}
