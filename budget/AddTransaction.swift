//
//  AddTransaction.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-02-04.
//

import SwiftUI

struct AddTransaction: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) var dismiss

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>

    var filteredCategories: [Category] {
        return categories.filter { CategoryType(rawValue: $0.type)?.rawValue == type.rawValue }
    }

    @State private var type: TransactionType = .expense
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var category: Category = Category()
    @State private var date: Date = .now

    var body: some View {
        NavigationView() {
            Form() {
                Picker("Transaction Type", selection: $type) {
                    ForEach(TransactionType.allCases, id: \.self) { transaction in
                        Text(transaction.displayString)
                    }
                }
                    .pickerStyle(.segmented)
                    .padding(.vertical)
                Section(header: Text("Amount")) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("$")
                        TextField(
                            "0",
                            text: $amount
                        )
                            .keyboardType(.decimalPad)
                    }
                }
                TextField("Name", text: $name)
                Picker("Category", selection: $category) {
                    ForEach(filteredCategories, id: \.self) {
                        Text($0.name)
                    }
                }
                Section(header: Text("Date")) {
                    DatePicker(
                        "Date",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                        .datePickerStyle(.automatic)
                }
            }
            .navigationTitle("New Transaction")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: addCategory) {
                        Text("Add")
                    }
                }
            }
        }
    }

    private func addCategory() {
        withAnimation {
            let newTransaction = Transaction(context: viewContext)
            newTransaction.id = UUID()
            newTransaction.timestamp = date
            newTransaction.name = name
            newTransaction.amount = NSDecimalNumber(string: amount)
            newTransaction.type = type.rawValue
            newTransaction.category = category

            do {
                try viewContext.save()
                dismiss()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddTransaction_Previews: PreviewProvider {
    static var previews: some View {
        AddTransaction()
    }
}