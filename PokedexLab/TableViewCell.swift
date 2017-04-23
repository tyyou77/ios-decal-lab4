//
//  TableViewCell.swift
//  PokedexLab
//
//  Created by Charles You on 2017-03-12.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var number: UILabel!
    
    @IBOutlet weak var keyStats: UILabel!
    
}
