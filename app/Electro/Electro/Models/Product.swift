import Foundation

struct Product: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let category: String
    let description: String
    let price: Double
    let imageUrl: URL
    let stock: Int

    var priceString: String { String(format: "$%.2f", price) }

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case category = "Category"
        case description = "Description"
        case price = "Price"
        case imageUrl = "ImageUrl"
        case stock = "Stock"
    }
}

extension Product {
    // Пример «товаров Apple» для секций MasterView
    static let sampleApple: [Product] = [
        Product(
            id: 101,
            name: "iPhone 14",
            category: "Phones",
            description: "Sample iPhone 14",
            price: 799,
            imageUrl: URL(string:
                "https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-14-3.jpg"
            )!,
            stock: 10
        ),
        Product(
            id: 102,
            name: "iPhone 14 Plus",
            category: " ",
            description: "Sample iPhone 14 Plus",
            price: 899,
            imageUrl: URL(string:
                "https://fdn2.gsmarena.com/vv/bigpic/apple-iphone-14-plus.jpg"
            )!,
            stock: 5
        ),
        Product(
            id: 103,
            name: "iPhone 14 Pro",
            category: "Phones",
            description: "Sample iPhone 14 Pro",
            price: 999,
            imageUrl: URL(string:
                "https://fdn2.gsmarena.com/vv/bigpic/apple-iphone-14-pro.jpg"
            )!,
            stock: 3
        ),
        Product(
            id: 104,
            name: "iPhone 14 Pro Max",
            category: "Phones",
            description: "Sample iPhone 14 Pro Max",
            price: 1099,
            imageUrl: URL(string:
                "https://fdn2.gsmarena.com/vv/bigpic/apple-iphone-14-pro-max-.jpg"
            )!,
            stock: 2
        ),
        Product(
            id: 105,
            name: "iPhone SE(2022)",
            category: "Phones",
            description: "Sample iPhone SE",
            price: 429,
            imageUrl: URL(string:
                "https://fdn2.gsmarena.com/vv/bigpic/apple-iphone-se-2022.jpg"
            )!,
            stock: 8
        )
    ]
}
