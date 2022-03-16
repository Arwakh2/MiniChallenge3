//
//  QuoteTableViewCell.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    @IBOutlet weak var AutherName: UILabel!
    @IBOutlet weak var BookName: UILabel!
    @IBOutlet weak var QuoteDate: UILabel!
    @IBOutlet weak var TheQuoteDe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
