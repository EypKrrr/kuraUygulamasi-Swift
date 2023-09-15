//
//  SortResultTableViewCell.swift
//  Second
//
//  Created by Eyup KORURER on 26.09.2021.
//

import UIKit

final class SortResultTableViewCell: UITableViewCell {

    @IBOutlet private weak var queLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
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
