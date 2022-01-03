//
//  ContentView.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-01.
//

import SwiftUI
import CoreData

struct TransactionList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: false)],
        animation: .default)
    private var transactions: FetchedResults<Transaction>

    var body: some View {
        NavigationView {
            List {
                ForEach(transactions) { transaction in
                    NavigationLink {
                        ScrollView() {                            Text(transaction.amount!, formatter: currencyFormatter)
                                .font(.title)
                            Text(TransactionType(rawValue: transaction.type)!.displayString)
                            Text(transaction.timestamp!, formatter: dateFormatter)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                EditButton()
                            }
                        }
                    } label: {
                        HStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.pink)
                                .frame(width: 28, height: 28)
                                .overlay(
                                    Image(systemName: "face.smiling")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                )
                                .padding(.trailing, 5)
                            VStack(alignment: .leading) {
                                Text("Apple One")
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                Text("Credit Card")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                        }
                        .badge(
                            Text(transaction.amount!, formatter: currencyFormatter)
                        )
                    }
                }
                .onDelete(perform: deleteItems)
                if transactions.isEmpty {
                    Text("No transactions")
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem {
                    if !transactions.isEmpty {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addItem) {
                        Label("Add Transaction", systemImage: "plus")
                    }
                }
            }
            Text("Select an transaction")
        }
    }

    private func addItem() {
        withAnimation {
            let newTransaction = Transaction(context: viewContext)
            newTransaction.timestamp = Date()
            newTransaction.amount = 25580.56
            newTransaction.type = TransactionType.expense.rawValue

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { transactions[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


enum TransactionType: Int32, CaseIterable {
    case income
    case expense
    case transfer
    
    var displayString: String {
        switch self {
        case .expense:
            return "Expense"
        case .income:
            return "Income"
        case .transfer:
            return "Transfer"
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

private let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
}()

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}