//
//  CatalogViewModel.swift
//  Electro
//
//  Created by Adel Mansurov on 03.06.2025.
//


// ViewModels/CatalogViewModel.swift
import Foundation
import Combine

final class CatalogViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published private(set) var filteredCategories: [Category] = []

    private var allCategories: [Category] = Category.sampleCategories
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Подписываемся на изменение searchText и пересчитываем filteredCategories
        $searchText
            .map { [weak self] text in
                self?.filterCategories(by: text) ?? []
            }
            .assign(to: \.filteredCategories, on: self)
            .store(in: &cancellables)

        // Сразу инициализируем полный список (empty search = все)
        filteredCategories = allCategories
    }

    private func filterCategories(by text: String) -> [Category] {
        guard !text.isEmpty else {
            return allCategories
        }
        return allCategories.filter { $0.name.localizedCaseInsensitiveContains(text) }
    }
}
