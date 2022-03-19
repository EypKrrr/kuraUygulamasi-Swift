//
//  TeamsViewController.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 29.09.2021.
//

import UIKit

class TeamsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    enum TableSection: Int {
        case input
        case teamCountPicker
        case twoButton
        case resultTitle
        case result
    }
    
    var inputItems : [InputModel] = []
    var resultItems : [TeamsResultModel] = []
    private var resultShouldVisable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputItems.append(InputModel(id: 1, value: ""))
        inputItems.append(InputModel(id: 2, value: ""))

        initVC()
    }
    
    func initVC() {
        
        tableView.delegate = self
        tableView.dataSource = self

        let twoButtonCell = UINib(nibName: TwoButtonTableViewCell.identifier, bundle: nil)
        tableView.register(twoButtonCell, forCellReuseIdentifier: TwoButtonTableViewCell.identifier)
        
        let inputCell = UINib(nibName: InputTableViewCell.identifier, bundle: nil)
        tableView.register(inputCell, forCellReuseIdentifier: InputTableViewCell.identifier)
        
        let wheelPickerCell = UINib(nibName: WheelPickerTableViewCell.identifier, bundle: nil)
        tableView.register(wheelPickerCell, forCellReuseIdentifier: WheelPickerTableViewCell.identifier)
        
        let resultTitleCell = UINib(nibName: ResultTitleTableViewCell.identifier, bundle: nil)
        tableView.register(resultTitleCell, forCellReuseIdentifier: ResultTitleTableViewCell.identifier)
        
        let teamsResultCell = UINib(nibName: TeamsResultTableViewCell.identifier, bundle: nil)
        tableView.register(teamsResultCell, forCellReuseIdentifier: TeamsResultTableViewCell.identifier)
    }
    
    func assignTeams() {
        guard let teamCount = checkTeamCount() else { return }
        
        for item in inputItems {
            let indexPath = IndexPath(row: item.id - 1, section: TableSection.input.rawValue)
            let multilineCell = tableView.cellForRow(at: indexPath) as! InputTableViewCell
            if multilineCell.input.text ?? "" != ""{
                inputItems[item.id - 1].value = multilineCell.input.text ?? ""
            }else{
                showAlert(title: "Uyarı", message: "\(item.id). Alan boş", buttonTitle: "Tamam", handler: nil)
                return
                
            }
        }
        
        let tempInputItems =  inputItems.shuffled()
        resultItems = [TeamsResultModel](repeating: TeamsResultModel(), count: teamCount)
        for (index, item) in tempInputItems.enumerated() {
            let id = index % teamCount
            resultItems[id].teamId = id + 1
            resultItems[id].members.append(ResultModel(id: item.id, value: item.value))
        }
        
        if !resultShouldVisable {
            resultShouldVisable = true
        }
        
        if tableView.numberOfSections == 3{
            let indexSet = IndexSet(integersIn: TableSection.resultTitle.rawValue...TableSection.result.rawValue)
            tableView.insertSections(indexSet, with: .automatic)
        }else{
            let indexSet = IndexSet(integer: TableSection.result.rawValue)
            tableView.reloadSections(indexSet, with: .automatic)
        }
        let resultTitleIndex = IndexPath(item: 0, section: TableSection.resultTitle.rawValue)
        tableView.scrollToRow(at: resultTitleIndex, at: .middle, animated: true)
    }
    
    private func cleanPage() {
        resultShouldVisable = false
        
        inputItems.removeAll()
        resultItems.removeAll()
        
        let pickerIndex = IndexPath(row: 0, section: TableSection.teamCountPicker.rawValue)
        let pickerCell = tableView.cellForRow(at: pickerIndex) as! WheelPickerTableViewCell
        pickerCell.pickerTextField.text = ""
        
        inputItems.append(InputModel(id: 1, value: ""))
        inputItems.append(InputModel(id: 2, value: ""))
        
        tableView.reloadData()
    }
    
    private func checkTeamCount() -> Int?{
        let pickerIndex = IndexPath(row: 0, section: TableSection.teamCountPicker.rawValue)
        let pickerCell = tableView.cellForRow(at: pickerIndex) as! WheelPickerTableViewCell
        
        if let teamCount = pickerCell.teamCount, teamCount > 0{
            if inputItems.count >= teamCount {
                return teamCount
            } else {
                showAlert(title: "Uyarı", message: "Takım sayısı kişi sayısından fazla olamaz", buttonTitle: "Tamam", handler: nil)
                return nil
            }
        }else{
            showAlert(title: "Uyarı", message: "Lütfen takım sayısını seçiniz", buttonTitle: "Tamam", handler: nil)
            return nil
        }
        
    }
    
}

//Tableview Delegate methods
extension TeamsViewController :  UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if resultShouldVisable {
            return 5
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TableSection.input.rawValue{
            return inputItems.count
        }else if section == TableSection.teamCountPicker.rawValue{
            return 1
        }else if section == TableSection.twoButton.rawValue{
            return 1
        }else if section == TableSection.resultTitle.rawValue{
            return 1
        }else if section == TableSection.result.rawValue{
            return resultItems.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == TableSection.input.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as! InputTableViewCell
            cell.setLabel(index: inputItems[indexPath.row].id, sectionNumber: indexPath.section, inputText: inputItems[indexPath.row].value, fieldType: .defaultType)
            cell.delegate = self
            return cell
        }else if indexPath.section == TableSection.teamCountPicker.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: WheelPickerTableViewCell.identifier, for: indexPath) as! WheelPickerTableViewCell
            cell.setCell(pickerTitle: "Takım Sayısı")
            return cell
        }else if indexPath.section == TableSection.twoButton.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: TwoButtonTableViewCell.identifier, for: indexPath) as! TwoButtonTableViewCell
            cell.setButtonTitles(leftBtnTitle: "Yeni Kişi Ekle", rightBtnTitle: "Takımlara Ayır")
            cell.tag = indexPath.section
            cell.delegate = self
            return cell
        }else if indexPath.section == TableSection.resultTitle.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultTitleTableViewCell.identifier, for: indexPath) as! ResultTitleTableViewCell
            cell.setTitle(text: "Takımlar")
            return cell
        }else if indexPath.section == TableSection.result.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamsResultTableViewCell.identifier, for: indexPath) as! TeamsResultTableViewCell
            cell.fillCell(currentTeam: self.resultItems[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
}

//TwoButtonCell Delegate methods
extension TeamsViewController : TwoButtonCellDelegate{
    func leftButtonTapped(tag: Int) {
        if tag == TableSection.twoButton.rawValue{
            let newId = self.inputItems.last!.id + 1
            inputItems.append(InputModel(id: newId, value: ""))
            tableView.beginUpdates()
            let selectedIndexPath = IndexPath(item:newId-1 , section: TableSection.input.rawValue)
            tableView.insertRows(at: [selectedIndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func rightButtonTapped(tag: Int) {
        if tag == TableSection.twoButton.rawValue{
            assignTeams()
        }
    }
}

//InputCell Delegate method
extension TeamsViewController: InputCellDelegate {
    func trashButtonTapped(row: Int, section: Int) {
        if inputItems.count > 2 {
            for (index, item) in inputItems.enumerated() {
                let indexPath = IndexPath(row: item.id - 1, section: section)
                let inputCell = tableView.cellForRow(at: indexPath) as! InputTableViewCell
                inputItems[item.id - 1].value = inputCell.input.text ?? ""
                if index >= row {
                    inputItems[index].id -= 1
                }
            }
            inputItems.remove(at: row)
            
            let indexSet = IndexSet(integer: section)
            tableView.reloadSections(indexSet, with: .automatic)
        }else{
            showAlert(title: "Uyarı", message: "Kişi sayısı 2'den az olamaz", buttonTitle: "Tamam", handler: nil)
            return
        }
    }
}
