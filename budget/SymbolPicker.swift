//
//  SymbolPicker.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-03.
//

import SwiftUI

private struct SFCategory: Identifiable {
    let name: String
    let icon: String
    let icons: Array<String>
    let id = UUID()
}

private let categories: [SFCategory] = [
    SFCategory(name: "Communication", icon: "message", icons: CategorySymbols.communication),
    SFCategory(name: "Weather", icon: "cloud.sun", icons: CategorySymbols.weather),
    SFCategory(name: "Objects & Tools", icon: "folder", icons: CategorySymbols.objectsTools),
    SFCategory(name: "Devices", icon: "desktopcomputer", icons: CategorySymbols.devices),
    SFCategory(name: "Gaming", icon: "gamecontroller", icons: CategorySymbols.gaming),
    SFCategory(name: "Connectivity", icon: "externaldrive.connected.to.line.below", icons: CategorySymbols.connectivity),
    SFCategory(name: "Transportation", icon: "car", icons: CategorySymbols.transportation),
    SFCategory(name: "Human", icon: "folder.badge.person.crop", icons: CategorySymbols.human),
    SFCategory(name: "Nature", icon: "leaf", icons: CategorySymbols.nature),
    SFCategory(name: "Editing", icon: "slider.horizontal.3", icons: CategorySymbols.editing),
    SFCategory(name: "Text Formatting", icon: "textformat", icons: CategorySymbols.textFormatting),
    SFCategory(name: "Media", icon: "playpause", icons: CategorySymbols.media),
    SFCategory(name: "Keyboard", icon: "command", icons: CategorySymbols.keyboard),
    SFCategory(name: "Commerce", icon: "cart", icons: CategorySymbols.commerce),
    SFCategory(name: "Time", icon: "timer", icons: CategorySymbols.time),
    SFCategory(name: "Health", icon: "heart", icons: CategorySymbols.health),
    SFCategory(name: "Shapes", icon: "square", icons: CategorySymbols.shapes),
    SFCategory(name: "Arrows", icon: "arrow.forward", icons: CategorySymbols.arrows),
    SFCategory(name: "Indices", icon: "a.circle", icons: CategorySymbols.indices),
    SFCategory(name: "Math", icon: "x.squareroot", icons: CategorySymbols.math)
]

struct SymbolPicker: View {
    @Binding var iconName: String
    
    @Environment(\.dismiss) private var dismiss
    @State private var symbolNames = CategorySymbols.transportation
    @State private var symbolNames2 = CategorySymbols.human
    @State private var localSymbol = "house.fill"
    @State private var color: Color = Color(.displayP3, red: 1.0, green: 1.0, blue: 1.0)
    @State private var iconColor: Color = Color(.displayP3, red: 0.16, green: 0.37, blue: 0.96)
    
    var columns = Array(repeating: GridItem(.flexible()), count: 5)

    var body: some View {
        GeometryReader { geometry in
            List() {
                ForEach(categories) { category in
                    NavigationLink {
                        ScrollView() {
                            LazyVGrid(columns: columns) {
                                ForEach(category.icons, id: \.self) { symbolItem in
                                    GroupBox() {
                                        Button {
                                            iconName = symbolItem
                                            dismiss()
                                        } label: {
                                            Image(systemName: symbolItem)
                                                .imageScale(.large)
                                                .symbolRenderingMode(.monochrome)
                                                .foregroundColor(.blue)
                                                .frame(maxWidth: 25, maxHeight: 25, alignment: .center)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .navigationTitle(category.name)
                    } label: {
                        Label(category.name, systemImage: category.icon)
                    }
                }
            }
        }
        .navigationTitle("SF Symbols")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}

struct SymbolPicker_Previews: PreviewProvider {
    static var previews: some View {
        SymbolPicker(iconName: .constant("house.fill"))
    }
}

struct SFSymbolStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .imageScale(.large)
            .symbolRenderingMode(.monochrome)
    }
}

extension View {
    func sfSymbolStyling() -> some View {
        modifier(SFSymbolStyling())
    }
}
