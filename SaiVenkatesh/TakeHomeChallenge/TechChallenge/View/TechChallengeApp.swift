import SwiftUI

@main
struct TechChallengeApp: App {
    @StateObject var allTransactions = AllTransactions()

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionListView(allTransactions: allTransactions)
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }

                NavigationView {
                    InsightsView(allTransactions: allTransactions)
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
        }
    }
}
