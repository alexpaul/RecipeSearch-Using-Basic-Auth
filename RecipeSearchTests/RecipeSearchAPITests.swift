//
//  RecipeSearchAPITests.swift
//  RecipeSearchTests
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import XCTest
@testable import RecipeSearch

class RecipeSearchAPITests: XCTestCase {

  
  func testSearchChristmasCookies() {
    // arrange
    // convert string to a url friendly string
    let searchQuery = "christmas cookies".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    let exp = XCTestExpectation(description: "searches found")
    let recipeEndpointURL = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appId)&app_key=\(SecretKey.appkey)&from=0&to=50"
    
    let request = URLRequest(url: URL(string: recipeEndpointURL)!)
    
    // act
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        XCTFail("appError: \(appError)")
      case .success(let data):
        exp.fulfill()
        // assert
        XCTAssertGreaterThan(data.count, 800000, "data should be greater than \(data.count)")
      }
    }
    wait(for: [exp], timeout: 5.0)
  }

  
  // 3. TODO: write an asynchronous test to validate you do get back 50 recipes for the
  // "christmas cookies" search from the fetchRecipes method
  func testFetchRecipes() {
    // arrange
    let expectedRecipesCount = 50
    let exp = XCTestExpectation(description: "recipes found")
    let searchQuery = "christmas cookies"
    
    // act
    RecipeSearchAPI.fetchRecipe(for: searchQuery) { (result) in
      switch result {
      case .failure(let appError):
        XCTFail("appError: \(appError)")
      case .success(let recipes):
        exp.fulfill()
        XCTAssertEqual(recipes.count, expectedRecipesCount)
      }
    }
    wait(for: [exp], timeout: 10.0)
  }
  
  
}
