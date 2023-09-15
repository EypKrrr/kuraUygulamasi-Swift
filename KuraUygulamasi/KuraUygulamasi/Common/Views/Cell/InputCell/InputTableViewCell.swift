//
//  InputTableViewCell.swift
//  Second
//
//  Created by Eyup KORURER on 14.09.2021.
//

import UIKit

protocol InputCellDelegate :AnyObject {
    func trashButtonTapped(row: Int, section: Int)
}

final class InputTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var inputLabel: UILabel!
    @IBOutlet private weak var input: UITextField!
    @IBOutlet private weak var trashButton: UIButton!
    
    weak var delegate: InputCellDelegate?
    
    var sectionNumber :Int?

    let field = ". Alan"
    
    enum FieldType: String {
        case defaultType = ". Kişi"
        case gift = ". Hediye"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        trashButton.imageEdgeInsets = UIEdgeInsets(top: 9.5, left: 10, bottom: 9.5, right: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setLabel(index: Int, sectionNumber: Int){
        inputLabel.text = "\(index)\(field)"
        input.text = ""
        tag = index - 1
        self.sectionNumber = sectionNumber
    }
    
    func setLabel(index: Int, sectionNumber: Int, inputText: String, fieldType: FieldType){
        inputLabel.text = "\(index)\(fieldType.rawValue)"
        input.text = inputText
        tag = index - 1
        self.sectionNumber = sectionNumber
    }
    
    func getInputText() -> String? {
        input.text
    }
    
    @IBAction func trashButtonTapped(_ sender: Any) {
        delegate?.trashButtonTapped(row: self.tag, section: self.sectionNumber ?? 0)
    }
}
