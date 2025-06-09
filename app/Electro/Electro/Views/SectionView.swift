import SwiftUI

struct SectionView: View {
    let title: String
    let products: [Product]
//    @EnvironmentObject private var navigationVM: NavigationViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(products) { product in
                        NavigationLink(value: Route.detail(product: product)) {
                            ProductCellView(product: product)
                                .frame(width: 150)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
