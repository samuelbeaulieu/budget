//
//  EditAccount.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-02-05.
//

import SwiftUI

struct EditAccount: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) var dismiss

    @Binding var account: Account

    var body: some View {
        Form() {
            Section(header: Text("Name")) {
                TextField("Name", text: $account.name)
            }
        }
        .navigationBarTitle("Edit Account")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(action: addAccount) {
                    Text("Done")
                }
            }
        }
    }

    private func addAccount() {
        withAnimation {
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

struct EditAccount_Previews: PreviewProvider {
    static var previews: some View {
        EditAccount(account: .constant(Account()))
    }
}
