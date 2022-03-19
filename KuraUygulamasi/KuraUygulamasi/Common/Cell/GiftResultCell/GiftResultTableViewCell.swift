//
//  GiftResultTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 20.01.2022.
//

import UIKit

class GiftResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    static let identifier = "GiftResultTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFields(leftText: String, rightText: String){
        leftLabel.text = leftText
        rightLabel.text = rightText
    }
    
}
