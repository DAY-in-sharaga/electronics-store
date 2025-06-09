//
//  ChatOptionsView.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// Views/ChatOptionsView.swift
import SwiftUI

struct ChatOptionsView: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel

    var body: some View {
        List {
            // 1. Позвонить в службу поддержки
            Button(action: {
                // Здесь могла бы быть логика, скажем, открытие URL с «tel:…»
            }) {
                HStack {
                    Image(systemName: "phone")
                        .foregroundColor(.blue)
                    Text("Позвонить в службу поддержки")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }

            // 2. Чат (наша внутренняя реализация)
            Button(action: {
                navigationVM.navigate(to: .chatRoom)
            }) {
                HStack {
                    Image(systemName: "bubble.left.and.bubble.right")
                        .foregroundColor(.blue)
                    Text("Чат")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }

            // 3. WhatsApp (заглушка)
            Button(action: {
                // Возможно, открытие URL: "https://wa.me/…” 
            }) {
                HStack {
                    Image("whatsapp") // локальная картинка WhatsApp (можно добавить в Assets)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("WhatsApp")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }

            // 4. Telegram (заглушка)
            Button(action: {
                // Открытие URL: "tg://resolve?domain=…"
            }) {
                HStack {
                    Image("telegram") // локальная картинка Telegram (можно добавить в Assets)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Telegram")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }

            // 5. Ответы на частые вопросы (заглушка)
            Button(action: {
                // Показать FAQ, тоже placeholder
            }) {
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                    Text("Ответы на частые вопросы")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Помощь")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatOptionsView()
                .environmentObject(NavigationViewModel())
        }
    }
}
