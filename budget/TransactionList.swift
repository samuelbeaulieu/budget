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

    @State private var showingSheet = false
    @State private var showingAddSheet = false

    func update(_ result: FetchedResults<Transaction>) -> [[Transaction]] {
        return Dictionary(grouping: result) { (element: Transaction) in
            Calendar.current.startOfDay(for: element.timestamp)
        }.values.sorted() {
            $0[0].timestamp > $1[0].timestamp
        }
    }

    func getTotalSpent(_ section: [Transaction], type: TransactionType) -> NSDecimalNumber {
        var total = NSDecimalNumber(decimal: 0)
        for transaction in section {
            if transaction.type == type.rawValue {
                total = total.adding(transaction.amount)
            }
        }
        return total
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(update(transactions), id: \.self) { (section: [Transaction]) in
                    Section(header: (
                        HStack() {
                            Text(section[0].timestamp, formatter: mediumDateFormatter)
                            Spacer()
                            Text(getTotalSpent(section, type: TransactionType.income), formatter: currencyFormatter)
                                .foregroundColor(.green)
                            Text(getTotalSpent(section, type: TransactionType.expense), formatter: currencyFormatter)
                                .foregroundColor(.red)
                        }
                    )) {
                        ForEach(section) { transaction in
                            NavigationLink {
                                ScrollView() {
                                    Text(transaction.amount, formatter: currencyFormatter)
                                        .font(.title)
                                    Text(TransactionType(rawValue: transaction.type)!.displayString)
                                    Text(transaction.timestamp, formatter: dateTimeFormatter)
                                    Text(transaction.category.name)
                                    Spacer()
                                }
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        EditButton()
                                    }
                                }
                            } label: {
                                TransactionRow(transaction: transaction)
                                    .contextMenu {
                                        Button {
                                            print("Edit")
                                        } label: {
                                            Label("Edit Transaction", systemImage: "pencil")
                                        }
                                        Button(role: .destructive) {
                                            if let index = transactions.firstIndex(of: transaction) {
                                                deleteItems(section: section, offsets: [index])
                                            }
                                        } label: {
                                            Label("Delete Transaction", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .onDelete { indexSet in
                            deleteItems(section: section, offsets: indexSet)
                        }
                        if transactions.isEmpty {
                            Text("No transactions")
                        }
                    }
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSheet = true
                    } label: {
                        Label("Open Settings", systemImage: "gearshape")
                    }
                }
                ToolbarItem {
                    if !transactions.isEmpty {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Label("Add Transaction", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                SettingsList()
            }
            .sheet(isPresented: $showingAddSheet) {
                AddTransaction()
            }
        }
    }

    private func deleteItems(section: [Transaction], offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let item = section[index]
                viewContext.delete(item)
            }

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

let dateTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
}()

let mediumDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
}()

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
