//
//  ContentView.swift
//  iExpense
//
//  Created by Brandon Coston on 3/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    var personalItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal"}
    }
    var businessItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business"}
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(personalItems) { item in
                        ExpenseListRow(item: item)
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, from: personalItems)
                    }
                } header: {
                    Text("Personal")
                }

                Section {
                    ForEach(businessItems) { item in
                        ExpenseListRow(item: item)
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, from: businessItems)
                    }
                } header: {
                    Text("Business")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet, from list: [ExpenseItem]) {
        for offset in offsets {
            let item = list[offset]
            expenses.items.removeAll { ei in
                ei.id == item.id
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
