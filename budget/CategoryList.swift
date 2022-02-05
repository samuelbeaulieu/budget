//
//  CategoryList.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-03.
//

import SwiftUI

struct CategoryList: View {
    var categoryType: CategoryType

    @State private var isAddingNewCategory = false
    @State private var isEditingCategory = false
    @State private var categoryToEdit = Category()

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>

    var filteredCategories: [Category] {
        return categories.filter { CategoryType(rawValue: $0.type) == categoryType }
    }

    var body: some View {
        List {
            ForEach(filteredCategories) { expense in
                CategoryRow(category: expense, isEditingCategory: $isEditingCategory, categoryToEdit: $categoryToEdit)
            }
            .onDelete(perform: deleteItems)
            if filteredCategories.isEmpty {
                Text("No categories")
            }
        }
        .navigationTitle("\(categoryType.displayString) Categories")
        .toolbar {
            ToolbarItem {
                if !filteredCategories.isEmpty {
                    EditButton()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddingNewCategory = true
                } label: {
                    Label("Add \(categoryType.displayString) Category", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingNewCategory) {
            NavigationView() {
                AddCategory(categoryType: categoryType)
            }
                .interactiveDismissDisabled(true)
        }
        .sheet(isPresented: $isEditingCategory) {
            NavigationView() {
                EditCategory(category: $categoryToEdit)
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newCategory = Category(context: viewContext)
            newCategory.id = UUID()
            newCategory.type = categoryType.rawValue
            newCategory.name = "Transportation"
//            newCategory.foregroundColor = UIColor.blue
//            newCategory.backgroundColor = UIColor.gray

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
        CategoryList(categoryType: .income).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
