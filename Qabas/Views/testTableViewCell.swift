//
//  testTableViewCell.swift
//  CardViewAnimation
//
//  Created by Ahad Obaid Albaqami on 10/08/1443 AH.
//  Copyright © 1443 Brian Advent. All rights reserved.
//

import UIKit

class testTableViewCell: UITableViewCell {

    @IBOutlet weak var testimage: UIImageView!
    @IBOutlet weak var test3: UILabel!
    @IBOutlet weak var test2: UILabel!
    @IBOutlet weak var test1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
