//
//  CategoryList.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-03.
//

import SwiftUI

struct CategoryList: View {
    @State private var isAddingNewCategory = false
    @State private var isEditingCategory = false
    @State private var categoryToEdit = Category()

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>

    var incomeCategories: [Category] {
        return categories.filter { CategoryType(rawValue: $0.type) == .income }
    }
    var expenseCategories: [Category] {
        return categories.filter { CategoryType(rawValue: $0.type) == .expense }
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Income")) {
                    ForEach(incomeCategories) { category in
                        CategoryRow(category: category, isEditingCategory: $isEditingCategory, categoryToEdit: $categoryToEdit)
                    }
                    .onDelete(perform: deleteItems)
                    if incomeCategories.isEmpty {
                        Text("No income categories")
                    }
                }
                .headerProminence(.increased)
                Section(header: Text("Expense")) {
                    ForEach(expenseCategories) { category in
                        CategoryRow(category: category, isEditingCategory: $isEditingCategory, categoryToEdit: $categoryToEdit)
                    }
                    .onDelete(perform: deleteItems)
                    if expenseCategories.isEmpty {
                        Text("No expense categories")
                    }
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem {
                    if !incomeCategories.isEmpty || !expenseCategories.isEmpty {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingNewCategory = true
                    } label: {
                        Label("Add Category", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isAddingNewCategory) {
            NavigationView() {
                AddCategory()
            }
        }
        .sheet(isPresented: $isEditingCategory) {
            NavigationView() {
                EditCategory(category: $categoryToEdit)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { categories[$0] }.forEach(viewContext.delete)

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

extension UIColor {
     class func color(data:Data) -> UIColor? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
