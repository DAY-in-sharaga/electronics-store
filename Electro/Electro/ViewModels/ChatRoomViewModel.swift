//
//  ChatRoomViewModel.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//

import Foundation
import Combine

final class ChatRoomViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessageText: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        // Подписываемся на изменения messages, пропускаем начальное состояние,
        // реагируем только на новые пользовательские сообщения
        $messages
            .dropFirst()
            .sink { [weak self] msgs in
                guard let self = self,
                      let last = msgs.last,
                      last.isUser else { return }
                self.simulateBotResponse()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            let reply = Message(
                text: "Спасибо за сообщение! Оператор свяжется с вами в ближайшее время.",
                isUser: false,
                timestamp: Date()
            )
            self.messages.append(reply)
        }
    }
}
