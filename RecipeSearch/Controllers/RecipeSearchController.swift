//
//  RecipeSearchController.swift
//  RecipeSearch
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeSearchController: UIViewController {
  // TODO: we need a table view
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  // we need a recipes array
  // on the recipes array have a didSet{} to update
  //       the table view
  var recipes = [Recipe](){
    didSet{
      DispatchQueue.main.async { //closure
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    searchBar.delegate = self
    searchRecipes(searchQuery: "christmas cookies")
    
    // set navigation bar title
    navigationItem.title = "Recipe Search"
  }
    
  
  // TODO: RecipeSearchAPI.fetchRecipes("mac and cheese") {...} accessing data to populate
  
  //       recipes array e.g "christmas cookies"
  
  func searchRecipes(searchQuery: String){
    RecipeSearchAPI.fetchRecipe(for: searchQuery, completion: {[weak self] (result) in
      switch result{
      case .failure(let appError):
        print("error \(appError)")
        // TODO: alert controller
      case .success(let recipes):
        self?.recipes = recipes
      }
    })
  }
  
  // show.secureURL(url)
  /*
   var secureURL: String {
    return url.replaceOccurrenceOf("http", "https")
   }
   */
}

extension RecipeSearchController: UITableViewDataSource{
  // TODO: in cellForRow show the recipe's label
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCell else {
      fatalError("could not dequeue a RecipeCell")
    }
    
    let recipe = recipes[indexPath.row]
    
    cell.configureCell(for: recipe)
    
    return cell
  }
}

extension RecipeSearchController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 400
  }
}


extension RecipeSearchController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // we will use a guard let to unwrap the searchBar.text property
    // because it's an optional
    
    // dismiss keyboard when the user clicks on the search button
    searchBar.resignFirstResponder()
    
    guard let searchText = searchBar.text else {
      print("missing search text")
      return
    }
    searchRecipes(searchQuery: searchText)
  }
}
