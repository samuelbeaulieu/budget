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
    @State private var iconName = "car.fill"
    @State private var foregroundColor: Color = Color(.displayP3, red: 0.16, green: 0.37, blue: 0.96)
    
    @State private var isPickingSymbol = false
    
    var body: some View {
        Form() {
            Section(header: Text("Preview")) {
                VStack() {
                    HStack() {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.clear)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: iconName)
                                    .foregroundColor(foregroundColor)
//                                    .font(.system(size: 22))
                                    .imageScale(.medium)
                            )
                        Text(category.name)
                            .foregroundColor(.black)
                    }
                }
                .listRowBackground(Color.white)
                VStack() {
                    HStack() {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.clear)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: iconName)
                                    .foregroundColor(foregroundColor)
                                    .imageScale(.large)
                            )
                        Text(category.name)
                            .foregroundColor(.white)
                    }
                }
                .listRowBackground(Color.black)
            }
            .padding(0)
            Section(header: Text("Category Name")) {
                TextField("Category Name", text: $category.name)
            }
            Section(header: Text("Icon")) {
                Button {
                    isPickingSymbol = true
                } label: {
                    HStack() {
                        Text("Symbol")
                        Spacer()
                        Image(systemName: iconName)
                    }
                }
                ColorPicker("Foreground color", selection: $foregroundColor, supportsOpacity: false)
//                ColorPicker("Background color", selection: $backgroundColor, supportsOpacity: false)
            }
        }
        .onAppear {
            name = category.name
//            iconName = category.iconName
            foregroundColor = Color(category.foregroundColor)
//            backgroundColor = Color(category.backgroundColor)
        }
        .navigationBarTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: dismissSheet) {
                    Text("Cancel")
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(action: addCategory) {
                    Text("Done")
                }
            }
        }
        .sheet(isPresented: $isPickingSymbol) {
            NavigationView {
                SymbolPicker(iconName: $iconName)
            }
        }
    }
    
    private func addCategory() {
        withAnimation {
            category.name = name
            category.iconName = iconName
            category.foregroundColor = UIColor(foregroundColor)
//            category.backgroundColor = UIColor(backgroundColor)
//            self.category.objectWillChange.send()

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

struct EditCategory_Previews: PreviewProvider {
    static var previews: some View {
        EditCategory(category: .constant(Category()))
    }
}
