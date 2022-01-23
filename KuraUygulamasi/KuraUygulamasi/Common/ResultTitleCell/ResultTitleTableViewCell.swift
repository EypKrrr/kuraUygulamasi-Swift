//
//  ResultTitleTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 19.01.2022.
//

import UIKit

class ResultTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel : UILabel!
    
    static let identifier = "ResultTitleTableViewCell"

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
