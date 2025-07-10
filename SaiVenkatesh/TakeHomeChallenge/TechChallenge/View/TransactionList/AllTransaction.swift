//
//  AllTransaction.swift
//  TechChallenge
//
//  Created by Sai Voruganti on 7/9/25.
//

import Foundation
import Combine

class AllTransactions: ObservableObject {
    @Published var transactions: [TransactionModel] = ModelData.sampleTransactions
}
