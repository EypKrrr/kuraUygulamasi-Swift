//
//  SortResultTableViewCell.swift
//  Second
//
//  Created by Eyup KORURER on 26.09.2021.
//

import UIKit

class SortResultTableViewCell: UITableViewCell {

    @IBOutlet weak var queLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = "SortResultTableViewCell"
    
    let que = ".Sıra"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabels(queText: Int, descriptionText: String) {
        queLabel.text = String(queText) + que
        descriptionLabel.text = descriptionText
        
    }
    
}
