import SwiftUI

@main
struct ElectroShopApp: App {
    @StateObject private var navigationVM = NavigationViewModel()
    @StateObject private var favoriteVM = FavoriteViewModel()
    @StateObject private var cartVM = CartViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationVM)
                .environmentObject(favoriteVM)
                .environmentObject(cartVM)
        }
    }
}
