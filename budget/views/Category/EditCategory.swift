//
//  EditCategory.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-16.
//

import SwiftUI

struct EditCategory: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) var dismiss

    @Binding var category: Category

    var body: some View {
        Form() {
            Section(header: Text("Name")) {
                TextField("Name", text: $category.name)
            }
        }
        .navigationBarTitle("Edit Category")
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
                    Text("Done")
                }
            }
        }
    }

    private func addCategory() {
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

struct EditCategory_Previews: PreviewProvider {
    static var previews: some View {
        EditCategory(category: .constant(Category()))
    }
}
