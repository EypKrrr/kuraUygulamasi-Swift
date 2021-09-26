//
//  InputTableViewCell.swift
//  Second
//
//  Created by Eyup KORURER on 14.09.2021.
//

import UIKit

class InputTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var input: UITextField!
    
    static let identifier = "InputTableViewCell"

    let field = ". Alan"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setLabel(index: Int){
        inputLabel.text = "\(index)\(field)"
    }
    
}
