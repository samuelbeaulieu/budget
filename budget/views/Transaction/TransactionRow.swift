//
//  TransactionRow.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-16.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction

    func getTransactionTypeColor(type: TransactionType) -> Color {
        switch type {
        case .income: return .green
        case .expense: return .red
        default:
            return .secondary
        }
    }

    func getTransactionAmount(amount: NSDecimalNumber, type: TransactionType) -> NSDecimalNumber {
        switch type {
        case .expense:
            return amount.decimalNumberByNegating()
        default:
            return amount
        }
    }

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(transaction.name)
                    .font(.headline)
                    .lineLimit(1)
                if TransactionType(rawValue: transaction.type) == .transfer {
                    HStack() {
                        Text(transaction.accountFrom.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.secondary)
                            .imageScale(.small)
                        Text(transaction.accountTo.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                } else {
                    HStack(alignment: .firstTextBaseline) {
                        Text(transaction.category.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            Spacer()
            Text(getTransactionAmount(amount: transaction.amount, type: TransactionType(rawValue: transaction.type)!), formatter: currencyFormatter)
                .foregroundColor(getTransactionTypeColor(type: TransactionType(rawValue: transaction.type)!))
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
        item.type = Int32.random(in: 0...2)
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
