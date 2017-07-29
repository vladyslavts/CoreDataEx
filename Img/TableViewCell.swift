//
//  TableViewCell.swift
//  Img
//
//  Created by Vlad on 28.07.17.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
