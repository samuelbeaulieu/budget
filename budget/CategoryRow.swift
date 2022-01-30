//
//  CategoryRow.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-16.
//

import SwiftUI

struct CategoryRow: View {
    var category: Category
    
    @Binding var isEditingCategory: Bool
    @Binding var categoryToEdit: Category
    
    var body: some View {
        HStack(alignment: .center) {
            Text(category.name)
            Text(CategoryType(rawValue: category.type)!.displayString)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
            Spacer()
            Button {
                categoryToEdit = category
                isEditingCategory = true
            } label: {
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .contextMenu {
            Button {
                categoryToEdit = category
                isEditingCategory = true
            } label: {
                Label("Edit Category", systemImage: "pencil")
            }
            Button(role: .destructive) {
//                if let index = categories.firstIndex(of: expense) {
//                    deleteItems(offsets: [index])
//                }
            } label: {
                Label("Delete Category", systemImage: "trash")
            }
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
        
    static var item: Category = {
        let context = persistence.container.viewContext
        let item = Category(context: context)
        item.id = UUID()
        item.name = "Transportation"
        item.foregroundColor = .blue
        item.type = Int32.random(in: 0...1)
        return item
    }()
    
    static var previews: some View {
        List() {
            NavigationLink {
                Text("Details View")
            } label: {
                CategoryRow(category: item, isEditingCategory: .constant(false), categoryToEdit: .constant(Category()))
                    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            }
        }
    }
}
