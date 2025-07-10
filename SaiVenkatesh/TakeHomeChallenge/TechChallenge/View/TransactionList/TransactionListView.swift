import SwiftUI

struct TransactionListView: View {
    @ObservedObject var allTransactions: AllTransactions
    @State private var selectedCategory: TransactionModel.Category? = nil

    var filteredTransactions: [TransactionModel] {
        selectedCategory == nil
            ? allTransactions.transactions
            : allTransactions.transactions.filter { $0.category == selectedCategory }
    }

    var pinnedTransactions: [TransactionModel] {
        filteredTransactions.filter { $0.isPinned }
    }

    var totalAmount: Double {
        pinnedTransactions.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        VStack(alignment: .leading) {
            // Category Scroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button(action: {
                        selectedCategory = nil
                    }) {
                        Text("All")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.black.opacity(selectedCategory == nil ? 0.8 : 0.4))
                            .cornerRadius(15)
                    }

                    ForEach(TransactionModel.Category.allCases, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                        }) {
                            Text(category.rawValue.capitalized)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    category.color.opacity(category == selectedCategory ? 0.8 : 0.4)
                                )
                                .cornerRadius(15)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .background(Color.gray.opacity(0.8))

            // Transaction List
            List {
                ForEach(filteredTransactions) { transaction in
                    TransactionView(transaction: transaction)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            togglePin(for: transaction)
                            
                        }
                }
            }
            .listStyle(PlainListStyle())
            .animation(.easeInOut, value: allTransactions.transactions)

            // Total
            HStack {
                Text("Total spent:")
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(selectedCategory?.rawValue.capitalized ?? "All")
                        .foregroundColor(selectedCategory?.color ?? .black)
                        .fontWeight(.semibold)
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.accentColor.opacity(0.8), lineWidth: 2)
            )
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .navigationBarTitle("Transactions", displayMode: .inline)
    }

    private func togglePin(for transaction: TransactionModel) {
        if let index = allTransactions.transactions.firstIndex(where: { $0.id == transaction.id }) {
            allTransactions.transactions[index].isPinned.toggle()
        }
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(allTransactions: AllTransactions())
    }
}
#endif

