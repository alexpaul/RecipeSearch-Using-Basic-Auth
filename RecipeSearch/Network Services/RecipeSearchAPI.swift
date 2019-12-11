//
//  RecipeSearchAPI.swift
//  RecipeSearch
//
//  Created by Alex Paul on 12/10/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct RecipeSearchAPI {
  
  static func fetchRecipe(for searchQuery: String,
                          completion: @escaping (Result<[Recipe], AppError>) -> ()) {
    
    let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "tacos"
    
    // using string interpolation to build endpoint url
    let recipeEndpointURL = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appId)&app_key=\(SecretKey.appkey)&from=0&to=50"
    
    // Later we will look at URLComponents and URLQueryItems 
    
    guard let url = URL(string: recipeEndpointURL) else {
      completion(.failure(.badURL(recipeEndpointURL)))
      return
    }
    
    let request = URLRequest(url: url)
        
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let searchResults = try JSONDecoder().decode(RecipeSearch.self, from: data)
          
          // 1. use searchResults to create an array of recipes
          let recipes = searchResults.hits.map { $0.recipe }
          
          // 2. capture the array of recipes in the completion handler
          completion(.success(recipes))
          
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
    
    
  }
  
}
