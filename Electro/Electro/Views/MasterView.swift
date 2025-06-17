import SwiftUI

struct MasterView: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @StateObject private var vm = MasterViewModel()
    @State private var showCitySheet = false

    var body: some View {
        VStack(spacing: 16) {
            // MARK: — Верхняя панель: выбор города и чат
            HStack {
                Button(action: { showCitySheet = true }) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(vm.selectedCity)
                    }
                }
                Spacer()
                Button(action: { navigationVM.navigate(to: .chat) }) {
                    Image(systemName: "message")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showCitySheet) {
                CitySelectionView(selectedCity: $vm.selectedCity)
            }

            // MARK: — Поиск
            TextField("Поиск...", text: $vm.searchText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            // Если есть ввод — показываем список результатов
            if !vm.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                List(vm.filteredProducts) { product in
                    Button {
                        navigationVM.navigate(to: .detail(product: product))
                    } label: {
                        HStack(spacing: 12) {
                            AsyncImage(url: product.imageUrl) { phase in
                                if let img = phase.image {
                                    img
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                } else if phase.error != nil {
                                    Color.gray
                                        .frame(width: 40, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                } else {
                                    ProgressView()
                                        .frame(width: 40, height: 40)
                                }
                            }
                            Text(product.name)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            // Иначе — стандартный дашборд с кнопками и секциями
            else {
                // MARK: — Навигационные кнопки
                VStack(spacing: 4) {
                    Button("Каталог") { navigationVM.navigate(to: .main) }
                        .frame(maxWidth: .infinity)
                        .frame(height: 20)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    Button("Личный кабинет") { navigationVM.navigate(to: .account) }
                        .frame(maxWidth: .infinity)
                        .frame(height: 20)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    Button("Избранное") { navigationVM.navigate(to: .favorite) }
                        .frame(maxWidth: .infinity)
                        .frame(height: 20)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    Button("Корзина") { navigationVM.navigate(to: .cart) }
                        .frame(maxWidth: .infinity)
                        .frame(height: 20)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)


                // MARK: — Горизонтальные секции
                ScrollView {
                    VStack(spacing: 24) {
                        SectionView(title: "Товары дня", products: vm.todayProducts)
                        SectionView(title: "Рекомендуем", products: vm.recommendedProducts)
                        SectionView(title: "Акции", products: vm.saleProducts)
                    }
                    .padding(.top)
                }
            }
        }
        .padding(.top)
    }
}


// Навигационные кнопки
