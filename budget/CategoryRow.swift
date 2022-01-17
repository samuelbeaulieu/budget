//
//  CategoryRow.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-16.
//

import SwiftUI

struct CategoryRow: View {
    var category: Category
    
    var body: some View {
        HStack(alignment: .center) {
            Rectangle()
                .fill(.clear)
                .frame(width: 35, height: 35)
                .overlay(
                    Image(systemName: category.iconName)
                        .foregroundColor(Color(category.foregroundColor))
                        .imageScale(.large)
                )
                .padding(.trailing, 5)
            Text(category.name)
            Text(CategoryType(rawValue: category.type)!.displayString)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
            Spacer()
            Button {
//                categoryToEdit = category
//                isEditingCategory = true
            } label: {
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .contextMenu {
            Button {
//                categoryToEdit = expense
//                isEditingCategory = true
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
    static var previews: some View {
        CategoryRow(category: Category())
    }
}
