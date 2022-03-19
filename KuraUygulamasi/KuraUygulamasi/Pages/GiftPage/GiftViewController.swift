//
//  GiftViewController.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 19.01.2022.
//

import UIKit

class GiftViewController: BaseViewController {

    @IBOutlet weak var giftTableView: UITableView!
    
    enum TableSection: Int {
        case giftInput
        case twoButton
        case input
        case oneButton
        case resultTitle
        case result
    }
    
    var giftItems : [InputModel] = []
    var fieldItems : [InputModel] = []
    var giftResults : [GiftResultModel] = []
    
    var resultShouldVisable : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftBarButton()
        giftItems.append(InputModel(id: 1, value: ""))
        
        fieldItems.append(InputModel(id: 1, value: ""))
        fieldItems.append(InputModel(id: 2, value: ""))
        initVC()
    }
    
    func initVC() {
        giftTableView.delegate = self
        giftTableView.dataSource = self
        
        let twoButtonCell = UINib(nibName: TwoButtonTableViewCell.identifier, bundle: nil)
        giftTableView.register(twoButtonCell, forCellReuseIdentifier: TwoButtonTableViewCell.identifier)
        
        let inputCell = UINib(nibName: InputTableViewCell.identifier, bundle: nil)
        giftTableView.register(inputCell, forCellReuseIdentifier: InputTableViewCell.identifier)
        
        let resultTitleCell = UINib(nibName: ResultTitleTableViewCell.identifier, bundle: nil)
        giftTableView.register(resultTitleCell, forCellReuseIdentifier: ResultTitleTableViewCell.identifier)
        
        let resultCell = UINib(nibName: GiftResultTableViewCell.identifier, bundle: nil)
        giftTableView.register(resultCell, forCellReuseIdentifier: GiftResultTableViewCell.identifier)
        
        let oneButtonCell = UINib(nibName: OneButtonTableViewCell.identifier, bundle: nil)
        giftTableView.register(oneButtonCell, forCellReuseIdentifier: OneButtonTableViewCell.identifier)
    }
    
    func distributeGifts() {
        giftResults.removeAll()
        
        for item in giftItems {
            let indexPath = IndexPath(row: item.id - 1, section: TableSection.giftInput.rawValue)
            let giftCell = giftTableView.cellForRow(at: indexPath) as! InputTableViewCell
            if giftCell.input.text ?? "" != ""{
                let giftText = giftCell.input.text ?? ""
                giftItems[item.id - 1].value = giftText
                giftResults.append(GiftResultModel(id: item.id, giftValue: giftText))
            }else{
                showAlert(title: "Uyarı", message: "\(item.id). Hediye boş", buttonTitle: "Tamam", handler: nil)
                return
                
            }
        }
        
        for item in fieldItems {
            let indexPath = IndexPath(row: item.id - 1, section: TableSection.input.rawValue)
            let fieldCell = giftTableView.cellForRow(at: indexPath) as! InputTableViewCell
            if fieldCell.input.text ?? "" != ""{
                fieldItems[item.id - 1].value = fieldCell.input.text ?? ""
            }else{
                showAlert(title: "Uyarı", message: "\(item.id). Alan boş", buttonTitle: "Tamam", handler: nil)
                return
            }
        }
        
        let shuffledFieldItems : [InputModel] = fieldItems.shuffled()
        
        for (index, _) in giftResults.enumerated() {
            giftResults[index].personName = shuffledFieldItems[index].value
        }
        
        if !resultShouldVisable {
            resultShouldVisable = true
        }

        insertResultRows()
    }
    
    func insertResultRows(){
        if giftTableView.numberOfSections == 4{
            let indexSet = IndexSet(integersIn: TableSection.resultTitle.rawValue...TableSection.result.rawValue)
            giftTableView.insertSections(indexSet, with: .automatic)
        }else{
            let indexSet = IndexSet(integer: TableSection.result.rawValue)
            giftTableView.reloadSections(indexSet, with: .automatic)
        }
        let resultTitleIndex = IndexPath(item: 0, section: TableSection.resultTitle.rawValue)
        giftTableView.scrollToRow(at: resultTitleIndex, at: .middle, animated: true)
    }
    
    func cleanPage(){
        resultShouldVisable = false
        
        giftItems.removeAll()
        fieldItems.removeAll()
        giftResults.removeAll()
        
        giftItems.append(InputModel(id: 1, value: ""))
        fieldItems.append(InputModel(id: 1, value: ""))
        fieldItems.append(InputModel(id: 2, value: ""))
        
        giftTableView.reloadData()
    }

}

extension GiftViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if resultShouldVisable{
            return 6
        }else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TableSection.giftInput.rawValue{
            return giftItems.count
        }else if section == TableSection.twoButton.rawValue{
            return 1
        }else if section == TableSection.input.rawValue{
            return fieldItems.count
        }else if section == TableSection.oneButton.rawValue{
            return 1
        }else if section == TableSection.resultTitle.rawValue{
            return 1
        }else if section == TableSection.result.rawValue{
            return giftResults.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == TableSection.giftInput.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as! InputTableViewCell
            cell.setLabel(index: giftItems[indexPath.row].id, sectionNumber: indexPath.section, inputText: giftItems[indexPath.row].value, fieldType: .gift)
            cell.delegate = self
            return cell
        }else if indexPath.section == TableSection.twoButton.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: TwoButtonTableViewCell.identifier, for: indexPath) as! TwoButtonTableViewCell
            cell.setButtonTitles(leftBtnTitle: "Hediye Ekle", rightBtnTitle: "Yeni Kişi Ekle")
            cell.tag = indexPath.section
            cell.delegate = self
            return cell
        }else if indexPath.section == TableSection.input.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as! InputTableViewCell
            cell.setLabel(index: fieldItems[indexPath.row].id, sectionNumber: indexPath.section, inputText: fieldItems[indexPath.row].value, fieldType: .defaultType)
            cell.delegate = self
            return cell
        }else if indexPath.section == TableSection.oneButton.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: OneButtonTableViewCell.identifier, for: indexPath) as! OneButtonTableViewCell
            cell.setButtonTitle(title: "Hediyeleri Dağıt")
            cell.tag = indexPath.section
            cell.delegate = self
            return cell
        }else if indexPath.section == TableSection.resultTitle.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultTitleTableViewCell.identifier, for: indexPath) as! ResultTitleTableViewCell
            cell.setTitle(text: "Talihliler")
            return cell
        }else if indexPath.section == TableSection.result.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: GiftResultTableViewCell.identifier, for: indexPath) as! GiftResultTableViewCell
            cell.setFields(leftText: giftResults[indexPath.row].giftValue, rightText: giftResults[indexPath.row].personName)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension GiftViewController: TwoButtonCellDelegate{
    func leftButtonTapped(tag: Int) {
        if tag == TableSection.twoButton.rawValue {
            if giftItems.count == fieldItems.count {
                showAlert(title: "Uyarı", message: "Hediye sayısı kişi sayısından fazla olamaz", buttonTitle: "Tamam", handler: nil)
                return
            }else{
                let newId = self.giftItems.last!.id + 1
                self.giftItems.append(InputModel(id: newId, value: ""))
                self.giftTableView.beginUpdates()
                let selectedIndexPath = IndexPath(item:newId-1 , section: TableSection.giftInput.rawValue)
                self.giftTableView.insertRows(at: [selectedIndexPath], with: .automatic)
                self.giftTableView.endUpdates()
                
            }
        }
    }
    
    func rightButtonTapped(tag: Int) {
        if tag == TableSection.twoButton.rawValue {
            let newId = self.fieldItems.last!.id + 1
            self.fieldItems.append(InputModel(id: newId, value: ""))
            self.giftTableView.beginUpdates()
            let selectedIndexPath = IndexPath(item:newId-1 , section: TableSection.input.rawValue)
            self.giftTableView.insertRows(at: [selectedIndexPath], with: .automatic)
            self.giftTableView.endUpdates()
        }
    }
}

extension GiftViewController: OneButtonTableViewCellDelegate {
    func buttonTapped(tag: Int) {
        if tag == TableSection.oneButton.rawValue {
            distributeGifts()
        }
    }
    
    
}

extension GiftViewController: InputCellDelegate {
    func trashButtonTapped(row: Int, section: Int) {
        if section == TableSection.giftInput.rawValue && giftItems.count <= 1 {
            showAlert(title: "Uyarı", message: "Hediye sayısı 1'den az olamaz", buttonTitle: "Tamam", handler: nil)
            return
        }else if section == 2 && fieldItems.count <= 2 {
            showAlert(title: "Uyarı", message: "Kişi sayısı 2'den az olamaz", buttonTitle: "Tamam", handler: nil)
            return
        }else{
            if section == TableSection.giftInput.rawValue {
                for (index, item) in giftItems.enumerated() {
                    let indexPath = IndexPath(row: item.id - 1, section: section)
                    let inputCell = giftTableView.cellForRow(at: indexPath) as! InputTableViewCell
                    giftItems[item.id - 1].value = inputCell.input.text ?? ""
                    if index >= row {
                        giftItems[index].id -= 1
                    }
                }
                giftItems.remove(at: row)
                
                let indexSet = IndexSet(integer: section)
                giftTableView.reloadSections(indexSet, with: .automatic)
            }else if section == TableSection.input.rawValue {
                for (index, item) in fieldItems.enumerated() {
                    let indexPath = IndexPath(row: item.id - 1, section: section)
                    let inputCell = giftTableView.cellForRow(at: indexPath) as! InputTableViewCell
                    fieldItems[item.id - 1].value = inputCell.input.text ?? ""
                    if index >= row {
                        fieldItems[index].id -= 1
                    }
                }
                fieldItems.remove(at: row)
                
                let indexSet = IndexSet(integer: section)
                giftTableView.reloadSections(indexSet, with: .automatic)
            }
        }
    }
}
