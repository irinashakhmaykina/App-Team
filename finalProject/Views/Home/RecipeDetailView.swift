//
//  RecipeDetailView.swift
//  finalProject
//
//  Created by Irina Shakhmaykina on 12/2/25.
//
import SwiftUI

struct RecipeDetailView: View {
    let recipeID: Int

    @State private var recipe: RecipeDetail?
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading recipe...")
                    .padding()
            } else if let errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else if let recipe {
                VStack(alignment: .leading, spacing: 16) {
                    Text(recipe.title)
                        .font(.largeTitle.bold())

                    if let imageURL = recipe.image,
                       let url = URL(string: imageURL) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    if let minutes = recipe.readyInMinutes {
                        Text("Ready in \(minutes) minutes")
                            .font(.subheadline)
                    }

                    if let servings = recipe.servings {
                        Text("Servings: \(servings)")
                            .font(.subheadline)
                    }

                    Divider()

                    // Ingredients
                    if let ingredients = recipe.extendedIngredients {
                        Text("Ingredients")
                            .font(.headline)

                        ForEach(ingredients) { ingredient in
                            Text("• \(ingredient.displayText)")
                        }
                    }

                    Divider()

                    // Instructions
                    if let instructions = recipe.instructions {
                        Text("Instructions")
                            .font(.headline)
                            .padding(.top, 8)

                        Text(instructions)
                            .multilineTextAlignment(.leading)
                    }

                    Spacer()
                }
                .padding()
            } else {
                Text("No recipe data.")
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadRecipe()
        }
    }

    private func loadRecipe() async {
        isLoading = true
        errorMessage = nil

        do {
            let detail = try await Recipe.shared.fetchRecipeInformation(id: recipeID)
            await MainActor.run {
                self.recipe = detail
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                self.errorMessage = "Failed to load recipe details."
            }
            print("Detail error:", error)
        }
    }
}

