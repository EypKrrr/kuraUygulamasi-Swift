//
//  TeamsResultInnerTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 28.12.2021.
//

import UIKit

final class TeamsResultInnerTableViewCell: UITableViewCell {

    @IBOutlet private weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(contentString : String) {
        contentLbl.text = contentString
    }
}
