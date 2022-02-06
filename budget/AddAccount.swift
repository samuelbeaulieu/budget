//
//  AddAccount.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-02-05.
//

import SwiftUI

struct AddAccount: View {
    @Environment(\.managedObjectContext) private var viewContext

    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""

    var body: some View {
        Form() {
            Section(header: Text("Account Name")) {
                TextField("Account Name", text: $name)
            }
        }
        .navigationTitle("New Account")
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
                    Text("Add")
                }
            }
        }
    }

    private func addAccount() {
        withAnimation {
            guard self.name != "" else {return}
            let newAccount = Account(context: viewContext)
            newAccount.id = UUID()
            newAccount.name = name

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

struct AddAccount_Previews: PreviewProvider {
    static var previews: some View {
        AddAccount()
    }
}
