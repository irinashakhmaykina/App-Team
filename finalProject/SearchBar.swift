//
//  SearchBar.swift
//  finalProject
//
//  Created by Irina Shakhmaykina on 12/2/25.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search recipes or ingredients", text: $text)
                .textInputAutocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

