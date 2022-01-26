//
//  TransactionRow.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-16.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction

    var body: some View {
        HStack(alignment: .center) {
            Rectangle()
                .fill(.clear)
                .frame(width: 35, height: 35)
                .overlay(
                    Image(systemName: "house")
                        .foregroundColor(.pink)
                        .imageScale(.large)
                )
                .padding(.trailing, 5)
            VStack(alignment: .leading) {
                Text(transaction.name!)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(TransactionType(rawValue: transaction.type)!.displayString)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .badge(
            Text(transaction.amount!, formatter: currencyFormatter)
        )
        .contextMenu {
            Button {
                print("Edit")
            } label: {
                Label("Edit Transaction", systemImage: "pencil")
            }
            Button(role: .destructive) {
//                if let index = transactions.firstIndex(of: transaction) {
//                    deleteItems(offsets: [index])
//                }
            } label: {
                Label("Delete Transaction", systemImage: "trash")
            }
        }
    }
}

extension NSDecimalNumber {
    /* returns (aDecimal x -1) */
    func decimalNumberByNegating() -> NSDecimalNumber {
        return self.multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true));
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
        
    static var item: Transaction = {
        let context = persistence.container.viewContext
        let item = Transaction(context: context)
        item.id = UUID()
        item.timestamp = Date()
        item.name = "Apple One"
        item.amount = NSDecimalNumber(decimal: 1000)
        item.type = Int32.random(in: 2...2)
        return item
    }()

    static var previews: some View {
        List() {
            NavigationLink {
                Text("Details View")
            } label: {
                TransactionRow(transaction: item)
                            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            }
        }
    }
}
