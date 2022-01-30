//
//  AddCategory.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-03.
//

import SwiftUI

struct AddCategory: View {
    var categoryType: CategoryType
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    
    @State private var foregroundColor: Color = Color(.displayP3, red: 0.16, green: 0.37, blue: 0.96)
//    @State private var backgroundColor: Color = Color(.displayP3, red: 1.0, green: 1.0, blue: 1.0)
    
    @State private var isPickingSymbol = false
    
    var body: some View {
        Form() {
            Section(header: Text("Preview")) {
                VStack() {
                    Text(name)
                        .foregroundColor(.black)
                }
                .listRowBackground(Color.white)
                VStack() {
                    Text(name)
                        .foregroundColor(.white)
                }
                .listRowBackground(Color.black)
            }
            .padding(0)
            Section(header: Text("Category Name")) {
                TextField("Category Name", text: $name)
            }
            Section(header: Text("Icon")) {
                ColorPicker("Foreground color", selection: $foregroundColor, supportsOpacity: false)
//                ColorPicker("Background color", selection: $backgroundColor, supportsOpacity: false)
            }
        }
        .navigationTitle("New \(categoryType.displayString) Category")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: dismissSheet) {
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
            newCategory.foregroundColor = UIColor(foregroundColor)
//            newCategory.backgroundColor = UIColor(backgroundColor)
            newCategory.type = categoryType.rawValue

            do {
                try viewContext.save()
                dismissSheet()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func dismissSheet() {
        dismiss()
    }
}

struct AddCategory_Previews: PreviewProvider {
    static var previews: some View {
        AddCategory(categoryType: .income)
    }
}
