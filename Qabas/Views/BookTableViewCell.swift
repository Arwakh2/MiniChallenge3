//
//  BookTableViewCell.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//

import UIKit


class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var BookImage: UIImageView!
    @IBOutlet weak var BookName: UILabel!
    @IBOutlet weak var AutherName: UILabel!
    @IBOutlet weak var BookDescription: UILabel!
    @IBOutlet weak var Ismarked: UIImageView!
    @IBOutlet weak var rateBook: UILabel!
    
    @IBOutlet weak var IsBookMarked: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
