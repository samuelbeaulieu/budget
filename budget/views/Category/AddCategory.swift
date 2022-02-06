//
//  AddCategory.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-03.
//

import SwiftUI

struct AddCategory: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var type: CategoryType = .expense
    
    @State private var foregroundColor: Color = Color(.displayP3, red: 0.16, green: 0.37, blue: 0.96)
//    @State private var backgroundColor: Color = Color(.displayP3, red: 1.0, green: 1.0, blue: 1.0)
    
    @State private var isPickingSymbol = false
    
    var body: some View {
        Form() {
            Picker("Transaction Type", selection: $type) {
                ForEach(CategoryType.allCases, id: \.self) { category in
                    Text(category.displayString)
                }
            }
                .pickerStyle(.segmented)
            Section(header: Text("Category Name")) {
                TextField("Category Name", text: $name)
            }
        }
        .navigationTitle("New Category")
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
    
    private func addCategory() {
        withAnimation {
            guard self.name != "" else {return}
            let newCategory = Category(context: viewContext)
            newCategory.id = UUID()
            newCategory.name = name
            newCategory.type = type.rawValue

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

struct AddCategory_Previews: PreviewProvider {
    static var previews: some View {
        AddCategory()
    }
}
