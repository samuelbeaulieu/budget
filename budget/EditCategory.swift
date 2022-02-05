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

    @State private var name: String = ""
    @State private var foregroundColor: Color = Color(.displayP3, red: 0.16, green: 0.37, blue: 0.96)
    
    @State private var isPickingSymbol = false
    
    var body: some View {
        Form() {
            Section(header: Text("Preview")) {
                VStack() {
                    Text(category.name)
                        .foregroundColor(.black)
                }
                .listRowBackground(Color.white)
                VStack() {
                    Text(category.name)
                        .foregroundColor(.white)
                }
                .listRowBackground(Color.black)
            }
            .padding(0)
            Section(header: Text("Category Name")) {
                TextField("Category Name", text: $category.name)
            }
            Section(header: Text("Icon")) {
                ColorPicker("Foreground color", selection: $foregroundColor, supportsOpacity: false)
//                ColorPicker("Background color", selection: $backgroundColor, supportsOpacity: false)
            }
        }
        .onAppear {
            name = category.name
            foregroundColor = Color(category.foregroundColor)
//            backgroundColor = Color(category.backgroundColor)
        }
        .navigationBarTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
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
            category.name = name
            category.foregroundColor = UIColor(foregroundColor)
//            category.backgroundColor = UIColor(backgroundColor)
//            self.category.objectWillChange.send()

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
