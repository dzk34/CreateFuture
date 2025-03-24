// Copyright © 2025 CreateFuture. All rights reserved.

import Foundation
import UIKit
import Combine

class CharactersViewController: UIViewController, UISearchControllerDelegate {
    @Inject(\.charactersViewModel) var viewModel: CharactersViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Data
    var cachedCharacters: [Character] = []
    var filteredData: [Character] = []

    func setupSearchController() {
        print("dzk setupSearchController")
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
//        self.searchController.searchBar.showsBookmarkButton = true
//        self.searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
    }
    
    func setupSearchController2() {
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.placeholder = "Search for your data"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.keyboardType = .default

        let placeholderAppearance = UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        placeholderAppearance.font = .systemFont(ofSize: 16)
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
//        searchBar.isHidden = true
        setupSearchController()
        
        viewModel.$characters
                    .sink { [weak self] characters in
                        self?.loadData(characters: characters)
                    }.store(in: &cancellables)
        
        Task {
            await viewModel.getCharacters()
        }
    }


    func loadData(characters: [Character]) {
        cachedCharacters = characters
        filteredData = cachedCharacters
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: filteredData[indexPath.row])
        return cell
    }
}


extension CharactersViewController: UISearchBarDelegate {
    func searchBar2(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchBar2 textDidChange for \(searchText)")
        viewModel.search(searchText: searchText)
        if searchText == "" {
            filteredData = cachedCharacters
        }
        
        for word in cachedCharacters {
            if word.name.lowercased().contains(searchText.lowercased()) {
                filteredData.append(word)
            }
        }
        
        
//        filteredData = cachedCharacters.filter { character in
//            character.name == searchText
//        }
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
        /*
        print("searchBar textDidChange for \(searchText), cachedCharacters.count=\(cachedCharacters.count), first=\(cachedCharacters.first?.name)")
        if searchText == "" {
            filteredData = cachedCharacters
        } else {
            let data = cachedCharacters.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
            filteredData = data
            print("dzk \(data.count), \(cachedCharacters.count), \(filteredData.count)")
        }
        print("filteredData = \(filteredData.count) cachedCharacters.count=\(cachedCharacters.count)")
        */
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
        filteredData = cachedCharacters
        tableView.reloadData()
    }
}



/*
public func updateSearchController(searchBarText: String?) {
    self.filteredCoins = allCoins

    if let searchText = searchBarText?.lowercased() {
        guard !searchText.isEmpty else { self.onCoinsUpdated?(); return }
        
        self.filteredCoins = self.filteredCoins.filter({ $0.name.lowercased().contains(searchText) })
    }
    
    self.onCoinsUpdated?()
}
*/

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("updateSearchResults")
    }
    
    public func updateSearchController(searchBarText: String?) {
        print("updateSearchController  \(searchBarText)")
        filteredData = cachedCharacters

        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { return }
            
            filteredData = filteredData.filter({ $0.name.lowercased().contains(searchText) })
        }
        
        tableView.reloadData()
    }

//    func updateSearchResults(for searchController: UISearchController) {
//        print("searching  \(searchController.searchBar.text)")
//        filteredData = cachedCharacters
//
//        if let searchText = searchBarText?.lowercased() {
//            guard !searchText.isEmpty else { self.onCoinsUpdated?(); return }
//            
//            self.filteredCoins = self.filteredCoins.filter({ $0.name.lowercased().contains(searchText) })
//        }
//
//    }
}
