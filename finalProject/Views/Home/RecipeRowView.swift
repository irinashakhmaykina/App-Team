//
//  RecipeRowView.swift
//  finalProject
//
//  Created by Irina Shakhmaykina on 12/2/25.
//
import SwiftUI

struct RecipeRowView: View {
    let recipe: RecipeSummary

    var body: some View {
        HStack {
            if let imageURL = recipe.image,
               let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                }
                placeholder: {
                    Color(.systemGray5)
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray.opacity(0.3))
                    .overlay(
                        Text("Img")
                            .font(.caption)
                    )
            }

            Text(recipe.title)
                .font(.headline)
                .lineLimit(2)

            Spacer()
        }
        .padding(12)
        .background(Color(red: 0.98, green: 0.78, blue: 0.88))
    }
}
