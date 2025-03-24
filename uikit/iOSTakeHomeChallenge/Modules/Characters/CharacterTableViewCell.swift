// Copyright © 2025 CreateFuture. All rights reserved.

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cultureLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!

    func setupWith(character: Character) {
        selectionStyle = .none
        nameLabel.text = character.name
        cultureLabel.text = character.culture
        bornLabel.text = character.born
        diedLabel.text = character.died
        seasonLabel.text = formatTvSeasons(tvSeries: character.tvSeries)
    }
    
    func formatTvSeasons(tvSeries: [String]) -> String {
        var seasons = ""

        for season in tvSeries {
            if season == "Season 1" {
                seasons.append("I ")
            } else if season == "Season 2" {
                seasons.append("II, ")
            } else if season == "Season 3" {
                seasons.append("III, ")
            } else if season == "Season 4" {
                seasons.append("IV, ")
            } else if season == "Season 5" {
                seasons.append("V, ")
            } else if season == "Season 6" {
                seasons.append("VI, ")
            } else if season == "Season 7" {
                seasons.append("VII, ")
            } else if season == "Season 8" {
                seasons.append("VIII")
            }
        }

        if (seasons.suffix(2) == ", ") {
            seasons.removeLast(2)
        }

        return seasons
    }
}
