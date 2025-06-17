//
//  ChatRoomViewModel.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// ViewModels/ChatRoomViewModel.swift
import Foundation
import Combine

final class ChatRoomViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessageText: String = ""

    // Здесь можно имитировать ответ оператора — каждый раз, когда пользователь отправляет, боту придёт «заглушка»
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Опционально: по таймеру или по отправке нового сообщения — бот ответит через секунду
        $messages
            .compactMap { _ in }
            .sink { [weak self] _ in
                self?.simulateBotResponse()
            }
            .store(in: &cancellables)
    }

    /// Пользователь нажал «Отправить» — добавляем сообщение в список
    func sendUserMessage() {
        let trimmed = newMessageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let msg = Message(text: trimmed, isUser: true, timestamp: Date())
        messages.append(msg)
        newMessageText = ""
    }

    /// Заглушка: ответ оператора через 1.5 секунды после последнего сообщения пользователя
    private func simulateBotResponse() {
        guard let last = messages.last, last.isUser else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            let reply = Message(text: "Спасибо за сообщение! Оператор свяжется с вами в ближайшее время.", isUser: false, timestamp: Date())
            self?.messages.append(reply)
        }
    }
}
