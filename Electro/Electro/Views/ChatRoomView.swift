//
//  ChatRoomView.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// Views/ChatRoomView.swift
import SwiftUI

struct ChatRoomView: View {
    @StateObject private var vm = ChatRoomViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // 1. Список сообщений
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(vm.messages) { msg in
                            HStack {
                                if msg.isUser {
                                    Spacer()
                                    Text(msg.text)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(Color.blue.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .trailing)
                                } else {
                                    Text(msg.text)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(Color(.systemGray5))
                                        .foregroundColor(.primary)
                                        .cornerRadius(12)
                                        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                                    Spacer()
                                }
                            }
                            .id(msg.id)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .onChange(of: vm.messages.count) { _ in
                    // Скроллим вниз при появлении нового сообщения
                    if let last = vm.messages.last {
                        scrollProxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }

            Divider()

            // 2. Поле ввода и кнопка «Отправить»
            HStack(spacing: 8) {
                TextField("Новое сообщение", text: $vm.newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 36)

                Button(action: {
                    vm.sendUserMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .rotationEffect(.degrees(45))
                        .font(.title2)
                        .foregroundColor(vm.newMessageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .blue)
                }
                .disabled(vm.newMessageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
        }
        .navigationTitle("Чат")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatRoomView()
        }
    }
}
