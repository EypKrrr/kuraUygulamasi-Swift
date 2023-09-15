//
//  WheelPickerTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 22.01.2022.
//

import UIKit

final class WheelPickerTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var pickerLabel: UILabel!
    @IBOutlet private weak var pickerTextField: UITextField!
    
    // TODO: - Remove !
    var pickerView : UIPickerView?
    
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
    
    func cleanTextField() {
        pickerTextField.text = ""
    }
    
}

extension WheelPickerTableViewCell: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickUp()
    }
    
    private func pickUp() {
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 200))
        pickerView?.delegate = self
        pickerView?.dataSource = self
        pickerView?.backgroundColor = .white

        if let teamCountText = pickerTextField.text, teamCountText != "" {
            teamCount = Int(teamCountText) ?? 2
        } else {
            teamCount = 2
            pickerTextField.text = "2"
        }
        let index = self.teamCount! - 2
        pickerView?.selectRow(index, inComponent: 0, animated: true)
        
        pickerTextField.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(doneTapped))
        doneButton.tintColor = .black
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        
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
        return teamCounts[safe: row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let teamCountText = teamCounts[safe: row] else { return }
        pickerTextField.text = teamCountText
        teamCount = Int(teamCountText) ?? 2
    }
}
