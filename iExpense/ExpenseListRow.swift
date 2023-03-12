//
//  ExpenseListRow.swift
//  iExpense
//
//  Created by Brandon Coston on 3/11/23.
//

import SwiftUI

struct ExpenseListRow: View {
    let item: ExpenseItem
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var color: Color {
        if item.amount < 10.0 {
            return Color.green
        } else if item.amount < 100.0 {
            return Color.yellow
        } else {
            return Color.red
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            Text(item.amount, format: .currency(code: currencyCode))
                .foregroundColor(color)
        }
    }
}

struct ExpenseListRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ExpenseListRow(item: .cheap)
            ExpenseListRow(item: .default)
            ExpenseListRow(item: .expensive)
        }
    }
}
