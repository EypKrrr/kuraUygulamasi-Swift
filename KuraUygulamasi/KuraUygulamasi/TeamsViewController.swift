//
//  TeamsViewController.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 29.09.2021.
//

import UIKit

class TeamsViewController: BaseViewController {
    
    @IBOutlet weak var teamsTableView: UITableView!
    
    
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
        
        teamsTableView.delegate = self
        teamsTableView.dataSource = self

        let twoButtonCell = UINib(nibName: TwoButtonTableViewCell.identifier, bundle: nil)
        teamsTableView.register(twoButtonCell, forCellReuseIdentifier: TwoButtonTableViewCell.identifier)
        
        let inputCell = UINib(nibName: InputTableViewCell.identifier, bundle: nil)
        teamsTableView.register(inputCell, forCellReuseIdentifier: InputTableViewCell.identifier)
        
        let wheelPickerCell = UINib(nibName: WheelPickerTableViewCell.identifier, bundle: nil)
        teamsTableView.register(wheelPickerCell, forCellReuseIdentifier: WheelPickerTableViewCell.identifier)
        
        let resultTitleCell = UINib(nibName: ResultTitleTableViewCell.identifier, bundle: nil)
        teamsTableView.register(resultTitleCell, forCellReuseIdentifier: ResultTitleTableViewCell.identifier)
        
        let teamsResultCell = UINib(nibName: TeamsResultTableViewCell.identifier, bundle: nil)
        teamsTableView.register(teamsResultCell, forCellReuseIdentifier: TeamsResultTableViewCell.identifier)
    }
    
    func assignTeams() {
        for item in inputItems {
            let indexPath = IndexPath(row: item.id - 1, section: 1)
            let multilineCell = teamsTableView.cellForRow(at: indexPath) as! InputTableViewCell
            if multilineCell.input.text ?? "" != ""{
                inputItems[item.id - 1].value = multilineCell.input.text ?? ""
            }else{
                let alert = UIAlertController(title: "Uyarı", message: "\(item.id). Alan boş", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
                
            }
        }
        let pickerIndex = IndexPath(row: 0, section: 2)
        let pickerCell = teamsTableView.cellForRow(at: pickerIndex) as! WheelPickerTableViewCell
        
        if let teamCount = pickerCell.teamCount, teamCount > 0{
            let tempInputItems =  inputItems.shuffled()
            resultItems = [TeamsResultModel](repeating: TeamsResultModel(), count: teamCount)
            for (index, item) in tempInputItems.enumerated() {
                let id = index % teamCount
                resultItems[id].teamId = id
                resultItems[id].members.append(ResultModel(id: item.id, value: item.value))
            }
            
            if !resultShouldVisable {
                resultShouldVisable = true
            }
            
            if teamsTableView.numberOfSections == 4{
                let indexSet = IndexSet(integersIn: 4...5)
                teamsTableView.insertSections(indexSet, with: .automatic)
            }else{
                let indexSet = IndexSet(integer: 5)
                teamsTableView.reloadSections(indexSet, with: .automatic)
            }
            let resultTitleIndex = IndexPath(item: 0, section: 4)
            teamsTableView.scrollToRow(at: resultTitleIndex, at: .middle, animated: true)

        }else{
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen takım sayısını seçiniz", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        
    }
    
    func cleanPage() {
        resultShouldVisable = false
        
        inputItems.removeAll()
        resultItems.removeAll()
        
        let pickerIndex = IndexPath(row: 0, section: 2)
        let pickerCell = teamsTableView.cellForRow(at: pickerIndex) as! WheelPickerTableViewCell
        pickerCell.pickerTextField.text = ""
        
        inputItems.append(InputModel(id: 1, value: ""))
        inputItems.append(InputModel(id: 2, value: ""))
        
        teamsTableView.reloadData()
    }
    
}

extension TeamsViewController :  UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if resultShouldVisable {
            return 6
        }else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return inputItems.count
        }else if section == 2{
            return 1
        }else if section == 3{
            return 1
        }else if section == 4{
            return 1
        }else if section == 5{
            return resultItems.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: TwoButtonTableViewCell.identifier, for: indexPath) as! TwoButtonTableViewCell
            cell.setButtonTitles(leftBtnTitle: "Yeni Alan Ekle", rightBtnTitle: "Alan Çıkar")
            cell.tag = indexPath.section
            cell.delegate = self
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as! InputTableViewCell
            cell.setLabel(index: inputItems[indexPath.row].id, fieldType: .defaultType)
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: WheelPickerTableViewCell.identifier, for: indexPath) as! WheelPickerTableViewCell
            cell.setCell(pickerTitle: "Takım Sayısı")
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: TwoButtonTableViewCell.identifier, for: indexPath) as! TwoButtonTableViewCell
            cell.setButtonTitles(leftBtnTitle: "Takımlara Ayır", rightBtnTitle: "Temizle")
            cell.tag = indexPath.section
            cell.delegate = self
            return cell
        }else if indexPath.section == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultTitleTableViewCell.identifier, for: indexPath) as! ResultTitleTableViewCell
            cell.setTitle(text: "Takımlar")
            return cell
        }else if indexPath.section == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamsResultTableViewCell.identifier, for: indexPath) as! TeamsResultTableViewCell
            cell.fillCell(currentTeam: self.resultItems[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension TeamsViewController : TwoButtonCellDelegate{
    func leftButtonTapped(tag: Int) {
        if tag == 0{
            let newId = self.inputItems.last!.id + 1
            self.inputItems.append(InputModel(id: newId, value: ""))
            self.teamsTableView.beginUpdates()
            let selectedIndexPath = IndexPath(item:newId-1 , section: 1)
            self.teamsTableView.insertRows(at: [selectedIndexPath], with: .automatic)
            self.teamsTableView.endUpdates()
        }else if tag == 3{
            assignTeams()
        }
    }
    
    func rightButtonTapped(tag: Int) {
        if tag == 0{
            if inputItems.count > 2 {
                self.inputItems.popLast()
                self.teamsTableView.beginUpdates()
                let selectedIndexPath = IndexPath(item:self.inputItems.count , section: 1)
                self.teamsTableView.deleteRows(at: [selectedIndexPath], with: .fade)
                self.teamsTableView.endUpdates()
            }else{
                let alert = UIAlertController(title: "Uyarı", message: "Alan sayısı 1'den az olamaz", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }else if tag == 3{
            cleanPage()
        }
    }
    

    
}
