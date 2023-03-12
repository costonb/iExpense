//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Brandon Coston on 3/11/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    static let `cheap` = ExpenseItem(name: "A Cheap Expense", type: "Personal", amount: 5.0)
    static let `default` = ExpenseItem(name: "A Normal Expense", type: "Personal", amount: 50.0)
    static let `expensive` = ExpenseItem(name: "An Expensive Expense", type: "Business", amount: 500.0)
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
