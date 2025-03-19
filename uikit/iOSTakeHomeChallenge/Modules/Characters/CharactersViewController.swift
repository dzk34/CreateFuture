// Copyright © 2025 CreateFuture. All rights reserved.

import Foundation
import UIKit

class CharactersViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    @Inject(\.charactersViewModel) var viewModel: CharactersViewModel

    var cachedCharacters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
    }


    func loadData(characters: [Character]) {
        cachedCharacters = characters
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedCharacters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: cachedCharacters[indexPath.row])
        return cell
    }
}
