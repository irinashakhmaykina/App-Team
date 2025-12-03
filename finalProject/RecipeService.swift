//
//  RecipeService.swift
//  finalProject
//
//  Created by Irina Shakhmaykina on 12/2/25.
//
import Foundation

enum RecipeError: Error{
    case invalidURL
    case requestFailed
    case decodingFailed
}

final class Recipe {
    static let shared = Recipe()
    
    private let apiKey = "3606fe6cde04422ca6bd0bf77b1ca69c"
    private let baseURL = "https://api.spoonacular.com"
    
    private init(){}
    
    func searchRecipes(query: String, searchByIngredients: Bool, number: Int = 10) async throws -> [RecipeSummary]{
        
        guard var components = URLComponents(string: "\(baseURL)/recipes/complexSearch")
        else{
            throw RecipeError.invalidURL
        }
        var items: [URLQueryItem] = [
            URLQueryItem(name: "apiKey", value: apiKey), URLQueryItem(name: "number", value: String(number))
        ]
        if searchByIngredients{
            items.append(URLQueryItem(name: "includeIngredients", value: query))
        }
        else{
            items.append(URLQueryItem(name: "query", value: query))
        }
        components.queryItems = items
        guard let url = components.url
        else{
            throw RecipeError.invalidURL
        }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            try validate(response: response)
            
            let decoded = try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
            return decoded.results
        }
        
        catch is DecodingError{
            throw RecipeError.decodingFailed
        }
        catch{
            throw RecipeError.requestFailed
        }
    }
    func fetchRecipeInformation(id: Int) async throws -> RecipeDetail {
        guard var components = URLComponents(string: "\(baseURL)/recipes/\(id)/information")
        else {
            throw RecipeError.invalidURL
        }
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        guard let url = components.url
        else{
            throw RecipeError.invalidURL
        }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            try validate(response: response)
            
            let decoded = try JSONDecoder().decode(RecipeDetail.self, from: data)
            return decoded
        }
        catch is DecodingError{
            throw RecipeError.decodingFailed
        }
        catch{
            throw RecipeError.requestFailed
        }
    }
    
    func fetchRandomRecipe() async throws -> RecipeDetail{
        guard var components = URLComponents(string: "\(baseURL)/recipes/random")
        else{
            throw RecipeError.invalidURL
        }
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey), URLQueryItem(name: "number", value: "1")
        ]
        guard let url = components.url else{
            throw RecipeError.invalidURL
        }
        struct RandomResponse: Codable{
            let recipes: [RecipeDetail]
        }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            try validate(response: response)
            
            let decoded = try JSONDecoder().decode(RandomResponse.self, from: data)
            guard let recipe = decoded.recipes.first
            else{
                throw RecipeError.decodingFailed
            }
            return recipe
        }
        
        catch is DecodingError{
            throw RecipeError.decodingFailed
        }
        catch{
            throw RecipeError.requestFailed
        }
    }
    private func validate(response: URLResponse)
    throws{
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode){
            throw RecipeError.requestFailed
        }
    }
}

