//
//  GiftResultTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 20.01.2022.
//

import UIKit

final class GiftResultTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var leftLabel: UILabel!
    @IBOutlet private weak var rightLabel: UILabel!
    
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
