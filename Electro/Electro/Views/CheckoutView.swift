//
//  CheckoutView.swift
//  Electro
//
//  Updated by ChatGPT on 2025-06-17.
//
import SwiftUI

struct CheckoutView: View {
    enum DeliveryMethod: String, CaseIterable, Identifiable {
        case pickup = "Самовывоз"
        case delivery = "Доставка"
        var id: String { rawValue }
    }

    enum PaymentMethod: String, CaseIterable, Identifiable {
        case cash = "Наличными"
        case card = "Картой"
        var id: String { rawValue }
    }

    struct Order {
        let items: [CartItem]
        let deliveryMethod: DeliveryMethod
        let location: String
        let address: String?
        let name: String
        let phone: String
        let payment: PaymentMethod
    }

    @EnvironmentObject private var cartVM: CartViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel

    @State private var deliveryMethod: DeliveryMethod = .pickup
    @State private var selectedCity: String = "Казань"
    @State private var address: String = ""
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var paymentMethod: PaymentMethod = .cash
    @State private var showConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Оформление заказа")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                // 1. Метод получения
                Picker("Метод получения", selection: $deliveryMethod) {
                    ForEach(DeliveryMethod.allCases) { method in
                        Text(method.rawValue).tag(method)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                // 2. Выбор города или ввод адреса
                if deliveryMethod == .pickup {
                    VStack(alignment: .leading) {
                        Text("Выберите город")
                            .font(.headline)
                        Picker("Город", selection: $selectedCity) {
                            Text("Казань").tag("Казань")
                            Text("Альметьевск").tag("Альметьевск")
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("Адрес доставки")
                            .font(.headline)
                        TextField("Введите адрес", text: $address)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }

                // 3. Данные покупателя
                VStack(alignment: .leading) {
                    Text("Покупатель")
                        .font(.headline)
                    TextField("Фамилия и имя", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Телефон", text: $phone)
                        .keyboardType(.phonePad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // 4. Способ оплаты
                VStack(alignment: .leading) {
                    Text("Способ оплаты")
                        .font(.headline)
                    Picker("Оплата", selection: $paymentMethod) {
                        ForEach(PaymentMethod.allCases) { method in
                            Text(method.rawValue).tag(method)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // 5. Кнопка "Заказать"
                Button(action: placeOrder) {
                    Text("Заказать")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
                        .foregroundColor(.white)
                }
                .padding(.top)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Оформить заказ")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showConfirmation) {
            Alert(
                title: Text("Заказ успешно оформлен"),
                dismissButton: .default(Text("OK"), action: {
                    navigationVM.path.removeAll()
                    navigationVM.navigate(to: .main)
                })
            )
        }
    }

    private func placeOrder() {
        let selectedItems = cartVM.items.filter { $0.isSelected }
        let order = Order(
            items: selectedItems,
            deliveryMethod: deliveryMethod,
            location: selectedCity,
            address: deliveryMethod == .delivery ? address : nil,
            name: name,
            phone: phone,
            payment: paymentMethod
        )
        print("Заказ сформирован: \(order)")
        showConfirmation = true
    }
}
