//
//  MainViewController.swift
//  Superheroes
//
//  Created by Michael Tseitlin on 4/9/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UICollectionViewController {
    
    private var superHeroes = [SuperHero]()
    
    private var filteredSuperHeroes = [SuperHero]()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let url = "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        fetchData()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? filteredSuperHeroes.count : superHeroes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        var superHeroe: SuperHero
        
        superHeroe = isFiltering ? filteredSuperHeroes[indexPath.row] : superHeroes[indexPath.row]
    
        cell.configureCell(superHero: superHeroe)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isFiltering {
            let filteredSuperHeroe = filteredSuperHeroes[indexPath.row]
            self.performSegue(withIdentifier: "showDVC", sender: filteredSuperHeroe)
        } else {
            let superHeroe = superHeroes[indexPath.row]
            self.performSegue(withIdentifier: "showDVC", sender: superHeroe)
        }
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDVC" {
            
            if let detailVC = segue.destination as? DetailVC {
                
                if isFiltering {
                    let filteredSuperHeroe = sender as? SuperHero
                    detailVC.superHero = filteredSuperHeroe
                } else {
                    let superHeroe = sender as? SuperHero
                    detailVC.superHero = superHeroe
                }
            }
        }
    }
    
    func fetchData() {
        
        guard let url = URL(string: url) else { return }
        
        request(url).validate().responseJSON { (dataResponse) in
            
            switch dataResponse.result {
                
            case .success(let value):
                
                if let superHeroes = SuperHero.getArray(from: value) {
                    self.superHeroes = superHeroes
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case.failure(let error):
                print(error)
            }
        }
        
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredSuperHeroes = superHeroes.filter({ (superHero: SuperHero) -> Bool in
            return superHero.name!.lowercased().contains(searchText.lowercased())
        })
        
        collectionView.reloadData()
    }
    
    private func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

