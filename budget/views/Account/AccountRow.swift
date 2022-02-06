//
//  AccountRow.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-02-05.
//

import SwiftUI

struct AccountRow: View {
    var account: Account

    @Binding var isEditingAccount: Bool
    @Binding var accountToEdit: Account

    var body: some View {
        HStack(alignment: .center) {
            Text(account.name)
            Spacer()
            Button {
                accountToEdit = account
                isEditingAccount = true
            } label: {
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .contextMenu {
            Button {
                accountToEdit = account
                isEditingAccount = true
            } label: {
                Label("Edit Account", systemImage: "pencil")
            }
            Button(role: .destructive) {
//                if let index = categories.firstIndex(of: expense) {
//                    deleteItems(offsets: [index])
//                }
            } label: {
                Label("Delete Account", systemImage: "trash")
            }
        }
    }
}

struct AccountRow_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
        
    static var item: Account = {
        let context = persistence.container.viewContext
        let item = Account(context: context)
        item.id = UUID()
        item.name = "RBC"
        return item
    }()
    
    static var previews: some View {
        List() {
            NavigationLink {
                Text("Details View")
            } label: {
                AccountRow(account: item, isEditingAccount: .constant(false), accountToEdit: .constant(Account()))
                    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            }
        }
    }
}
