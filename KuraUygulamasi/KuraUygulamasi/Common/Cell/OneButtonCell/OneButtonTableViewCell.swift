//
//  OneButtonTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 26.02.2022.
//

import UIKit

protocol OneButtonTableViewCellDelegate: AnyObject {
    func buttonTapped(tag: Int)
}

class OneButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    let cornerRadius: CGFloat = 4
    weak var delegate: OneButtonTableViewCellDelegate?
    static let identifier = "OneButtonTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initCell() {
        button.layer.cornerRadius = cornerRadius
    }
    
    func setButtonTitle(title: String) {
        button.setTitle(title, for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.delegate?.buttonTapped(tag: self.tag)
    }
    
    
}
