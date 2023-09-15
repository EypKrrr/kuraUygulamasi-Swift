//
//  TwoButtonTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 19.01.2022.
//

import UIKit

protocol TwoButtonCellDelegate :AnyObject {
    func leftButtonTapped(tag: Int)
    func rightButtonTapped(tag: Int)
}

final class TwoButtonTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    
    weak var delegate: TwoButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setButtonTitles(leftBtnTitle:String, rightBtnTitle:String) {
        leftButton.setTitle(leftBtnTitle, for: .normal)
        rightButton.setTitle(rightBtnTitle, for: .normal)
    }
    
    @IBAction func leftBtnTapped(_ sender: Any) {
        delegate?.leftButtonTapped(tag: self.tag)
    }
    
    @IBAction func rightBtnTapped(_ sender: Any) {
        delegate?.rightButtonTapped(tag: self.tag)
    }
    
}
