// Copyright © 2025 CreateFuture. All rights reserved.

import Foundation
import UIKit
import Combine

class CharactersViewController: UIViewController, UISearchControllerDelegate {
    @Inject(\.charactersViewModel) var viewModel: CharactersViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        setupSearchController()
        
        viewModel.$characters
                    .sink { [weak self] characters in
                        DispatchQueue.main.async { [weak self] in
                            self?.tableView.reloadData()
                        }
                    }.store(in: &cancellables)
        
        Task {
            await viewModel.getCharacters()
        }
    }

    func setupSearchController() {
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
    }
}

// MARK: - TableView Component
extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: viewModel.characters[indexPath.row])
        return cell
    }
}

// MARK: - Search Component
extension CharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.search(searchText: "")
        tableView.reloadData()
    }
}
