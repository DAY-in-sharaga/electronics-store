//Неактуальная версия кода на данный момент
//import SwiftUI
//
//struct MainView: View {
//    @StateObject private var productVM = ProductListViewModel()
//    private let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
////    @EnvironmentObject private var navigationVM: NavigationViewModel
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Каталог товаров")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding(.horizontal)
//
//            ScrollView {
//                LazyVGrid(columns: columns, spacing: 16) {
//                    ForEach(productVM.products) { product in
//                        // Навигация напрямую через value-based API:
//                        NavigationLink(value: Route.detail(product: product)) {
//                            ProductCellView(product: product)
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                    }
//                }
//                .padding(.horizontal)
//            }
//        }
//        .padding(.top)
//    }
//}

// Views/CatalogView.swift
import SwiftUI

struct CatalogView: View {
    @StateObject private var vm = CatalogViewModel()
    @EnvironmentObject private var navigationVM: NavigationViewModel

    var body: some View {
        VStack(spacing: 0) {
            // 1. Поисковая строка (только по категориям)
            TextField("Название категории", text: $vm.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.vertical, 8)

            // 2. Список категорий
            List {
                ForEach(vm.filteredCategories) { category in
                    Button(action: {
                        if category.filterKey == "Phones" {
                            // Только «Смартфоны и гаджеты» ведёт к товарам
                            navigationVM.navigate(to: .categoryProducts(filterKey: category.filterKey))
                        } else {
                            // Заглушка: просто ничего не делает или showToast
                        }
                    }) {
                        HStack {
                            Image(systemName: category.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blue)
                            Text(category.name)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Каталог")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CatalogView()
                .environmentObject(NavigationViewModel())
        }
    }
}
