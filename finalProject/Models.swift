import Foundation

struct RecipeSearchResponse: Codable{
    let results: [RecipeSummary]
    let offset: Int?
    let number: Int?
    let totalResults: Int?
}

struct RecipeSummary: Identifiable, Codable{
    let id: Int
    let title: String
    let image: String?
}

struct RecipeDetail: Codable{
    let id: Int
    let title: String
    let image: String?
    let readyInMinutes: Int?
    let servings: Int?
    let summary: String?
    let instructions: String?
    let extendedIngredients: [Ingredient]?
}

struct Ingredient: Identifiable, Codable{
    let id: Int?
    let original: String
    let name: String?
    
    var displayText: String{
        original
    }
}
