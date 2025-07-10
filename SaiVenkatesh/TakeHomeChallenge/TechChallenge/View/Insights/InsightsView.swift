import SwiftUI

struct InsightsView: View {
    @ObservedObject var allTransactions: AllTransactions

    private var pinnedTransactions: [TransactionModel] {
        allTransactions.transactions.filter { $0.isPinned }
    }

    private var categoryTotals: [TransactionModel.Category: Double] {
        Dictionary(grouping: pinnedTransactions, by: { $0.category })
            .mapValues { $0.reduce(0) { $0 + $1.amount } }
    }

    var body: some View {
        List {
            VStack {
                Text("Pinned Transactions by Category")
                    .font(.headline)
                    .padding(.bottom, 4)

                RingView(transactions: pinnedTransactions)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 8)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            ForEach(TransactionModel.Category.allCases) { category in
                let total = categoryTotals[category] ?? 0
                if total > 0 {
                    HStack {
                        Text(category.rawValue.capitalized)
                            .font(.headline)
                            .foregroundColor(category.color)
                        Spacer()
                        Text("$\(total, specifier: "%.2f")")
                            .bold()
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Insights")
        .navigationBarTitleDisplayMode(.inline)
    }
}


