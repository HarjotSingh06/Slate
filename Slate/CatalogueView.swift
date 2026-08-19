import SwiftUI
import SwiftData

struct CatalogueItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

struct CatalogueView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: ProductViewModel?
    @State private var searchText = ""
    
    private let hapticFeedback = UINotificationFeedbackGenerator()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    let shopItems: [CatalogueItem] = [
        CatalogueItem(name: "Blue Shirt", price: 7.99),
        CatalogueItem(name: "White Shoes", price: 9.99),
        CatalogueItem(name: "Red Pants", price: 12.50),
        CatalogueItem(name: "White Pants", price: 9.99)
    ]
    
    var filteredItems: [CatalogueItem] {
        if searchText.isEmpty {
            return shopItems
        } else {
            return shopItems.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredItems) { item in
                        let tempProduct = Product(name: item.name, price: item.price)
                        
                        NavigationLink(destination: ProductDetailView(name: item.name, price: item.price)) {
                            VStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(height: 120)
                                    .overlay(
                                        Image(systemName: tempProduct.iconName)
                                            .font(.system(size: 44))
                                            .foregroundColor(.black.opacity(0.8))
                                    )
                                
                                Text(item.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text("£\(item.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Button(action: {
                                    hapticFeedback.notificationOccurred(.success)
                                    viewModel?.addToBasket(name: item.name, price: item.price)
                                }) {
                                    Text("Add to Basket")
                                        .frame(maxWidth: .infinity)
                                        .fontWeight(.medium)
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.pink)
                                // Prevents the button tap from opening the NavigationLink destination
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gray.opacity(0.2))
                            )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Shop")
            .searchable(text: $searchText, prompt: "Search clothes...")
        }
        .onAppear {
            if viewModel == nil {
                viewModel = ProductViewModel(modelContext: modelContext)
            } else {
                viewModel?.fetchProducts()
            }
        }
    }
}
