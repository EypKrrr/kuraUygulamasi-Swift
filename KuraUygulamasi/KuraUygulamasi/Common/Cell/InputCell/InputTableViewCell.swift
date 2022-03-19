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

class InputTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var trashButton: UIButton!
    
    weak var delegate: InputCellDelegate?
    
    static let identifier = "InputTableViewCell"
    
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
        self.tag = index - 1
        self.sectionNumber = sectionNumber
    }
    
    func setLabel(index: Int, sectionNumber: Int, inputText: String, fieldType: FieldType){
        inputLabel.text = "\(index)\(fieldType.rawValue)"
        input.text = inputText
        self.tag = index - 1
        self.sectionNumber = sectionNumber
    }
    
    @IBAction func trashButtonTapped(_ sender: Any) {
        self.delegate?.trashButtonTapped(row: self.tag, section: self.sectionNumber ?? 0)
    }
        
}
