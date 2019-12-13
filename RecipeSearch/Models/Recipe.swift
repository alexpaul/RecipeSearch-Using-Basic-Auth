//
//  Recipe.swift
//  RecipeSearch
//
//  Created by Alex Paul on 12/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct RecipeSearch: Decodable {
  let hits: [Hit]
}

struct Hit: Decodable {
  let recipe: Recipe
}

struct Recipe: Decodable {
  let label: String
  let image: String
}
