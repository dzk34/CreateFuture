// Copyright © 2025 CreateFuture. All rights reserved.

import Foundation
import UIKit
import Combine

class CharactersViewController: UIViewController {
    @Inject(\.charactersViewModel) var viewModel: CharactersViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var tableView: UITableView!

    var cachedCharacters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        
        viewModel.$characters
                    .sink { [weak self] characters in
                        self?.loadData(characters: characters)
                    }.store(in: &cancellables)
        
        Task.init {
            await viewModel.getCharacters()
        }
    }


    func loadData(characters: [Character]) {
        cachedCharacters = characters
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedCharacters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: cachedCharacters[indexPath.row])
        return cell
    }
}
