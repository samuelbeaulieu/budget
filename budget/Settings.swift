//
//  SettingsList.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-02.
//

import SwiftUI

struct SettingsList: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) var dismiss
    
    @State private var toggleCrashAnalytics = true
    
    var body: some View {
        NavigationView() {
            List() {
                Section(header: Text("Categories")) {
                    NavigationLink {
                        ScrollView() {
                            Text("Manage Income Categories")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem() {
                                EditButton()
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: dismissSheet) {
                                    Label("Add Transaction", systemImage: "plus")
                                }
                            }
                        }
                    } label: {
                        Label {
                            Text("Manage Income")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.green)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "folder.fill.badge.plus")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                    NavigationLink {
                        ScrollView() {
                            Text("Manage Expenses Categories")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem() {
                                EditButton()
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: dismissSheet) {
                                    Label("Add Transaction", systemImage: "plus")
                                }
                            }
                        }
                    } label: {
                        Label {
                            Text("Manage Expenses")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.red)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "folder.fill.badge.minus")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                }
                .headerProminence(.increased)
                Section(header: Text("Accounts")) {
                    NavigationLink {
                        ScrollView() {
                            Text("Manage Accounts")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem() {
                                EditButton()
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: dismissSheet) {
                                    Label("Add Account", systemImage: "plus")
                                }
                            }
                        }
                    } label: {
                        Label {
                            Text("Manage Accounts")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.brown)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "briefcase.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                }
                .headerProminence(.increased)
                Section() {
                    NavigationLink {
                        ScrollView() {
                            Text("Details")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label {
                            Text("About")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.blue)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "at")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                    NavigationLink {
                        ScrollView() {
                            Text("Details")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label {
                            Text("Tip Jar")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.orange)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "bitcoinsign.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                    NavigationLink {
                        ScrollView() {
                            Text("Details")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label {
                            Text("Budget Pro")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.indigo)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "bolt.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                }
                Section() {
                    NavigationLink {
                        ScrollView() {
                            Text("Details")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label {
                            Text("Rate Budget")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.pink)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                    NavigationLink {
                        ScrollView() {
                            Text("Details")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label {
                            Text("Help")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.yellow)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "questionmark")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                    NavigationLink {
                        ScrollView() {
                            Text("Details")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label {
                            Text("Feedback")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.blue)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "mail.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                    Link(destination: URL(string: "https://github.com/samuelbeaulieu/budget/blob/master/README.md")!) {
                        HStack() {
                            Label {
                                Text("Roadmap")
                                    .foregroundColor(.black)
                            } icon: {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(.gray)
                                    .frame(width: 27, height: 27)
                                    .overlay(
                                        Image(systemName: "calendar")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16))
                                    )
                            }
                            Spacer()
                            Image(systemName: "link")
                                .font(.footnote)
                                .foregroundColor(.accentColor)
                        }
                    }
                    NavigationLink {
                        ScrollView() {
                            Text("Details")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label {
                            Text("Feature Requests")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.purple)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "rhombus.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                    NavigationLink {
                        ScrollView() {
                            Text("Details")
                                .font(.title)
                            Spacer()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label {
                            Text("Bug Reports")
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.green)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "ladybug.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                    NavigationLink {
                        List() {
                            Section(footer: Text("Anonymous, and greatly helps to improve the app by providing insight into common crashes and most commonly used features. More details in Privacy Policy.")) {
                                Toggle("Crash Reporting & Analytics", isOn: $toggleCrashAnalytics)
                            }
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label {
                            Text("Crash Reporting & Analytics") // See Apollo for Reddit app
                        } icon: {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.green)
                                .frame(width: 27, height: 27)
                                .overlay(
                                    Image(systemName: "ladybug.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: dismissSheet) {
                        Text("Done")
                    }
                }
            }
            Text("Select a setting")
        }
    }
    
    private func dismissSheet() {
        dismiss()
    }
}

struct SettingsList_Previews: PreviewProvider {
    static var previews: some View {
        SettingsList()
    }
}
