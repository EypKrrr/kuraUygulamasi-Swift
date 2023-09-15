//
//  ResultTitleTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 19.01.2022.
//

import UIKit

final class ResultTitleTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitle(text: String){
        titleLabel.text = text
    }
}
