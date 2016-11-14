// Chance Turner
//  ListTableViewCell.swift
//  Trello
//
//  Created by Events on 11/13/16.
//  Copyright © 2016 Oklahoma Christian. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editButton(sender: UIButton) {
        
    }
}
