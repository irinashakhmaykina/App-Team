//
//  HomeView.swift
//  finalProject
//
//  Created by Irina Shakhmaykina on 12/2/25.
//
import SwiftUI

struct HomeView: View{
    @State private var searchText = ""
    @State private var searchByIngredients = false
    @State private var recipes: [RecipeSummary] = []
    @State private var isLoading = false
    @State private var errorMessage: String? = nil
    
    var body: some View{
        VStack(spacing: 16){
            Spacer()
            Text("Cook Book")
                .font(.largeTitle.bold())
            SearchBar(text: $searchText)
            Toggle("Search by ingredients", isOn: $searchByIngredients)
                .toggleStyle(.switch)
            HStack{
                Button("Search"){
                    Task{
                        await performSearch()
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Random Recipe"){
                    Task{
                        await loadRandomRecipe()
                    }
                }
                .buttonStyle(.bordered)
            }
            
            if isLoading{
                ProgressView("Loading recipes...")
            }
            else if let errorMessage{
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            List{
                ForEach(recipes) {
                    recipe in
                    NavigationLink{
                        RecipeDetailView(recipeID: recipe.id)
                    }
                    label:{
                        RecipeRowView(recipe: recipe)
                    }
                }
            }
            .listStyle(.plain)
        }
        .padding()
        .navigationTitle("Home")
        .background(Color(red: 1.000, green: 0.898, blue: 0.925))
    }
    
    private func performSearch() async {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let results = try await Recipe.shared.searchRecipes(
                query: trimmed,
                searchByIngredients: searchByIngredients,
                number: 15
            )
            // Update UI state on main actor
            await MainActor.run {
                self.recipes = results
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                self.errorMessage = "Failed to load recipes. Please try again."
            }
            print("Search error:", error)
        }
    }

    private func loadRandomRecipe() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let randomRecipe = try await Recipe.shared.fetchRandomRecipe()
            let summary = RecipeSummary(
                id: randomRecipe.id,
                title: randomRecipe.title,
                image: randomRecipe.image
            )
            await MainActor.run {
                self.recipes = [summary]
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                self.errorMessage = "Failed to load random recipe."
            }
            print("Random error:", error)
        }
    }
}

