import Testing
@testable import Electro

/// В этом файле мы создаём четыре юнит-теста для ключевых ViewModel.
/// Обратите внимание: для очистки коллекций мы используем публичные методы,
/// а не прямое присвоение, потому что свойства доступны только на чтение.
struct ElectroTests {
    
    // 1. Тест CartViewModel: добавление одного и того же товара
    @Test
    func testCartViewModel_AddingSameProduct() throws {
        // Подготавливаем ViewModel
        let cartVM = CartViewModel()
        // Очищаем корзину с помощью метода remove(_:)
        while !cartVM.items.isEmpty {
            let item = cartVM.items[0]
            cartVM.remove(item)
        }
        
        // Берём первый продукт из примера
        let product = Product.sampleApple.first!
        
        // Дважды добавляем один и тот же товар
        cartVM.add(product)
        cartVM.add(product)
        
        // Проверяем, что в корзине ровно один элемент с quantity = 2
        #expect(cartVM.items.count == 1, "Должен быть один CartItem после двух добавлений одного продукта")
        #expect(cartVM.items[0].quantity == 2, "Количество должно быть 2 после двух добавлений")
        
        // Проверяем totalPrice = price * quantity
        let expectedTotal = product.price * 2
        #expect(cartVM.totalPrice == expectedTotal, "Итоговая сумма должна равняться price * quantity")
    }
    
    // 2. Тест CatalogViewModel: фильтрация категорий по строке поиска
    @Test
    func testCatalogViewModel_FilterCategoriesBySearchText() throws {
        let catalogVM = CatalogViewModel()
        catalogVM.searchText = "Смартфоны"
        
        // Должно быть хотя бы одна категория
        #expect(!catalogVM.filteredCategories.isEmpty, "filteredCategories не должны быть пустыми для 'Смартфоны'")
        
        // Все названия должны содержать 'Смартфоны'
        for category in catalogVM.filteredCategories {
            #expect(category.name.localizedCaseInsensitiveContains("Смартфоны"),
                    "Категория \(category.name) должна содержать 'Смартфоны'")
        }
    }
    
    // 3. Тест FavoriteViewModel: добавление и удаление из избранного
    @Test
    func testFavoriteViewModel_AddAndRemoveFavorite() throws {
        let favoriteVM = FavoriteViewModel()
        // Очищаем через remove(_:)
        for product in favoriteVM.favorites {
            favoriteVM.remove(product)
        }
        
        let product = Product.sampleApple[1]
        
        // Добавляем и проверяем
        favoriteVM.add(product)
        #expect(favoriteVM.contains(product), "После добавления contains должно вернуть true")
        #expect(favoriteVM.favorites.count == 1, "В избранном должен быть один элемент")
        
        // Повторно добавляем — дубликата не должно быть
        favoriteVM.add(product)
        #expect(favoriteVM.favorites.count == 1, "Повторное добавление не создаёт дубликат")
        
        // Удаляем и проверяем
        favoriteVM.remove(product)
        #expect(!favoriteVM.contains(product), "После удаления contains должно вернуть false")
        #expect(favoriteVM.favorites.isEmpty, "Список избранного должен быть пуст")
    }

}
