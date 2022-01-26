//
//  TransactionRow.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-16.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction

    func getTransactionTypeColor(type: Int32) -> Color {
        switch type {
        case 0: return .green
        case 1: return .red
        default:
            return .secondary
        }
    }

    func getTransactionAmount(amount: NSDecimalNumber, type: Int32) -> NSDecimalNumber {
        switch type {
        case 1:
            return amount.decimalNumberByNegating()
        default:
            return amount
        }
    }

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(transaction.name!)
                    .font(.headline)
                    .lineLimit(1)
                if transaction.type == 2 {
                    HStack() {
                        Text("Chequing")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.secondary)
                            .imageScale(.small)
                        Text("Questrade")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                } else {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Transportation")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            Spacer()
            Text(getTransactionAmount(amount: transaction.amount!, type: transaction.type), formatter: currencyFormatter)
                .foregroundColor(getTransactionTypeColor(type: transaction.type))
        }
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
