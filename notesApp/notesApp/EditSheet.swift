//
//  EditSheet.swift
//  notesApp
//
//  Created by Irina Shakhmaykina on 10/13/25.
//

import SwiftUI

struct EditSheet: View {
    @Binding var title: String
    @Binding var selectedColor: Color
    
    var body: some View {
        VStack(spacing: 20) {
            // TODO: Add list.bullet.circle.fill icon and TextField
            HStack(spacing: 10) {
                Image(systemName: "list.bullet.circle.fill")
                    .imageScale(.large)
                TextField("List name", text: $title)
                    .textFieldStyle(.roundedBorder)
            }
            
            ColorChooser(selectedColor: $selectedColor)
            
            Spacer()
        }
        .foregroundStyle(selectedColor)
        .padding()
    }
}

#Preview {
    @Previewable @State var title: String = ""
    @Previewable @State var selectedColor: Color = .red
    EditSheet(title: $title, selectedColor: $selectedColor)
        .preferredColorScheme(.dark)
}
