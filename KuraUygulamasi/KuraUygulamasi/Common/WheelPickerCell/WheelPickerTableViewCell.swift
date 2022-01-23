//
//  WheelPickerTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 22.01.2022.
//

import UIKit

class WheelPickerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pickerLabel: UILabel!
    @IBOutlet weak var pickerTextField: UITextField!
    
    var pickerView : UIPickerView!
    
    static let identifier = "WheelPickerTableViewCell"
    
    let teamCounts = ["2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    var teamCount : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(pickerTitle: String ){
        pickerTextField.delegate = self
        pickerLabel.text = pickerTitle
    }
    
}

extension WheelPickerTableViewCell: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickUp()
    }
    
    func pickUp() {
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 200))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white

        if let teamCountText = pickerTextField.text, teamCountText != ""{
            self.teamCount = Int(teamCountText) ?? 2
        }else{
            self.teamCount = 2
            pickerTextField.text = "2"
        }
        let index = self.teamCount! - 2
        pickerView.selectRow(index, inComponent: 0, animated: true)
        
        pickerTextField.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(doneTapped))
        
        let spaceButton = UIBarButtonItem(systemItem: .flexibleSpace)
        
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        pickerTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneTapped() {
        pickerTextField.resignFirstResponder()
    }
}

extension WheelPickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teamCounts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teamCounts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = teamCounts[row]
        teamCount = Int(teamCounts[row]) ?? 2
    }
    
    
}
