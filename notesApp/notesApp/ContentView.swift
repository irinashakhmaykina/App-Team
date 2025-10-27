//
//  ContentView.swift
//  notesApp
//
//  Created by Irina Shakhmaykina on 10/13/25.
//

import SwiftUI


struct ContentView: View {
    @State private var isEditing: Bool = false
    // TODO: Add an @State property to hold a RemindersPage struct
    @State private var page: RemindersPage = RemindersPage(
        title: "My Reminders",
        items: [
            Reminder(title: "Buy Milk", isCompleted: false)
        ],
        color: .blue
    )
    
    
    var body: some View {
        VStack {
            // TODO: Add header view
            HStack {
                Image(systemName: "list.bullet.circle.fill")
                Text(page.title)
                    .font(.title2).fontWeight(.semibold).foregroundStyle(page.color)
                Spacer()
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            }
            .padding(.horizontal)
            
            List {
                // TODO: Loop through the page's reminders using ForEach
                ForEach($page.items) { $reminder in
                    // TODO: Display each reminder row
                    HStack {
                        Toggle("", isOn: $reminder.isCompleted)
                            .labelsHidden()
                        TextField("Title", text: $reminder.title)
                    }
                    .foregroundStyle(page.color)
                }
                .onDelete { indexSet in
                    page.items.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            
            // TODO: Add footer view
            
            HStack {
                Button {
                    page.items.append(Reminder(title: "New Reminder"))
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Reminder")
                    }
                }
                .padding(.vertical, 8)
                Spacer()
            }
            .padding(.horizontal)
        }
        .tint(page.color)
        .sheet(isPresented: $isEditing) {
            // TODO: Add remaining binding
            EditSheet(title: $page.title, selectedColor: $page.color)
        }
    }
}

#Preview {
    ContentView()
}
