//
//  AccountList.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-02-05.
//

import SwiftUI

struct AccountList: View {
    @State private var isAddingNewAccount = false
    @State private var isEditingAccount = false
    @State private var accountToEdit = Account()

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Account.name, ascending: true)],
        animation: .default)
    private var accounts: FetchedResults<Account>

    var body: some View {
        NavigationView {
            List {
                ForEach(accounts) { account in
                    AccountRow(account: account, isEditingAccount: $isEditingAccount, accountToEdit: $accountToEdit)
                }
                .onDelete(perform: deleteItems)
                if accounts.isEmpty {
                    Text("No accounts")
                }
            }
            .navigationTitle("Accounts")
            .toolbar {
                ToolbarItem {
                    if !accounts.isEmpty {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingNewAccount = true
                    } label: {
                        Label("Add Account", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isAddingNewAccount) {
            NavigationView() {
                AddAccount()
            }
        }
        .sheet(isPresented: $isEditingAccount) {
            NavigationView() {
                EditAccount(account: $accountToEdit)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { accounts[$0] }.forEach(viewContext.delete)

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

struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        AccountList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
