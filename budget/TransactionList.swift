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
    
    var filteredTransactions: [Transaction] {
        return transactions.filter { Calendar.current.isDateInMonth($0.timestamp, currentMonth) }
    }
    
    func update(_ result: [Transaction]) -> [[Transaction]] {
        return Dictionary(grouping: result) { (element: Transaction) in
            Calendar.current.startOfDay(for: element.timestamp)
//            Calendar.current.isDateInThisMonth(element.timestamp)
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

    func getBalance(_ section: [Transaction]) -> NSDecimalNumber {
        var total = NSDecimalNumber(decimal: 0)
        for transaction in section {
            if transaction.type == TransactionType.expense.rawValue {
                total = total.subtracting(transaction.amount)
            }
            if transaction.type == TransactionType.income.rawValue {
                total = total.adding(transaction.amount)
            }
        }
        return total
    }

    @State private var currentMonth = 0
    @State private var month = Calendar.current.date(byAdding: .month, value: 0, to: Date())

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack(alignment: .center) {
                        VStack() {
                            Text(getTotalSpent(update(filteredTransactions).first ?? [], type: TransactionType.income), formatter: currencyFormatter)
                                .padding(.bottom, 1)
                            Text("Income")
                        }
                        Spacer()
                        Divider()
                        Spacer()
                        VStack() {
                            Text(getTotalSpent(update(filteredTransactions).first ?? [], type: TransactionType.expense), formatter: currencyFormatter)
                                .padding(.bottom, 1)
                            Text("Expenses")
                        }
                        Spacer()
                        Divider()
                        Spacer()
                        VStack() {
                            Text(getBalance(update(filteredTransactions).first ?? []), formatter: currencyFormatter)
                                .padding(.bottom, 1)
                            Text("Balance")
                        }
                    }
                    .padding()
                }
                Section {
                    HStack() {
                        Button {
                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                            impactMed.impactOccurred()
                            currentMonth = currentMonth - 1
                        } label: {
                            Label("Previous Month", systemImage: "chevron.left")
                                .labelStyle(.iconOnly)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.blue)
                        .onChange(of: currentMonth) { newValue in
                            month = Calendar.current.date(byAdding: .month, value: newValue, to: Date())
                        }
                        Spacer()
                        Text(month!, formatter: monthDateFormatter)
                        Spacer()
                        Button {
                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                            impactMed.impactOccurred()
                            currentMonth = currentMonth + 1
                        } label: {
                            Label("Next Month", systemImage: "chevron.right")
                                .labelStyle(.iconOnly)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                }
                ForEach(update(filteredTransactions), id: \.self) { (section: [Transaction]) in
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
                                            if let index = filteredTransactions.firstIndex(of: transaction) {
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
                    }
                }
                if filteredTransactions.isEmpty {
                    Text("No transactions")
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
                    if !filteredTransactions.isEmpty {
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

let monthDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM YYYY"
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

struct ControlGroupWithTitle: ControlGroupStyle {
    let title: LocalizedStringKey

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Text(title)
                .font(.title)
            HStack {
                configuration.content
            }
        }
    }
}


extension Calendar {
  private var currentDate: Date { return Date() }

  func isDateInThisWeek(_ date: Date) -> Bool {
    return isDate(date, equalTo: currentDate, toGranularity: .weekOfYear)
  }

  func isDateInThisMonth(_ date: Date) -> Bool {
    return isDate(date, equalTo: currentDate, toGranularity: .month)
  }

  func isDateInNextWeek(_ date: Date) -> Bool {
    guard let nextWeek = self.date(byAdding: DateComponents(weekOfYear: 1), to: currentDate) else {
      return false
    }
    return isDate(date, equalTo: nextWeek, toGranularity: .weekOfYear)
  }

  func isDateInNextMonth(_ date: Date) -> Bool {
    guard let nextMonth = self.date(byAdding: DateComponents(month: 1), to: currentDate) else {
      return false
    }
    return isDate(date, equalTo: nextMonth, toGranularity: .month)
  }

  func isDateInFollowingMonth(_ date: Date) -> Bool {
    guard let followingMonth = self.date(byAdding: DateComponents(month: 2), to: currentDate) else {
      return false
    }
    return isDate(date, equalTo: followingMonth, toGranularity: .month)
  }
    
    func isDateInMonth(_ date: Date, _ month: Int) -> Bool {
      guard let followingMonth = self.date(byAdding: DateComponents(month: month), to: currentDate) else {
        return false
      }
      return isDate(date, equalTo: followingMonth, toGranularity: .month)
    }
}
