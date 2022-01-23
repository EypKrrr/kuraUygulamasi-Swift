//
//  GiftViewController.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 19.01.2022.
//

import UIKit

class GiftViewController: BaseViewController {

    @IBOutlet weak var giftTableView: UITableView!
    
    var giftItems : [InputModel] = []
    var fieldItems : [InputModel] = []
    var giftResults : [GiftResultModel] = []
    
    var resultShouldVisable : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    func distributeGifts() {
        giftResults.removeAll()
        
        for item in giftItems {
            let indexPath = IndexPath(row: item.id - 1, section: 1)
            let giftCell = giftTableView.cellForRow(at: indexPath) as! InputTableViewCell
            if giftCell.input.text ?? "" != ""{
                let giftText = giftCell.input.text ?? ""
                giftItems[item.id - 1].value = giftText
                giftResults.append(GiftResultModel(id: item.id, giftValue: giftText))
            }else{
                let alert = UIAlertController(title: "Uyarı", message: "\(item.id). Hediye boş", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
                
            }
        }
        
        for item in fieldItems {
            let indexPath = IndexPath(row: item.id - 1, section: 3)
            let fieldCell = giftTableView.cellForRow(at: indexPath) as! InputTableViewCell
            if fieldCell.input.text ?? "" != ""{
                fieldItems[item.id - 1].value = fieldCell.input.text ?? ""
            }else{
                let alert = UIAlertController(title: "Uyarı", message: "\(item.id). Alan boş", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
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
        if giftTableView.numberOfSections == 5{
            let indexSet = IndexSet(integersIn: 5...6)
            giftTableView.insertSections(indexSet, with: .automatic)
        }else{
            let indexSet = IndexSet(integer: 6)
            giftTableView.reloadSections(indexSet, with: .automatic)
        }
        let resultTitleIndex = IndexPath(item: 0, section: 5)
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
            return 7
        }else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1{
            return giftItems.count
        }else if section == 2{
            return 1
        }else if section == 3{
            return fieldItems.count
        }else if section == 4{
            return 1
        }else if section == 5{
            return 1
        }else if section == 6{
            return giftResults.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: TwoButtonTableViewCell.identifier, for: indexPath) as! TwoButtonTableViewCell
            cell.setButtonTitles(leftBtnTitle: "Hediye Ekle", rightBtnTitle: "Hediye Çıkar")
            cell.tag = indexPath.section
            cell.delegate = self
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as! InputTableViewCell
            cell.setLabel(index: giftItems[indexPath.row].id, fieldType: .gift)
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: TwoButtonTableViewCell.identifier, for: indexPath) as! TwoButtonTableViewCell
            cell.setButtonTitles(leftBtnTitle: "Yeni Alan Ekle", rightBtnTitle: "Alan Çıkar")
            cell.tag = indexPath.section
            cell.delegate = self
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as! InputTableViewCell
            cell.setLabel(index: fieldItems[indexPath.row].id, fieldType: .defaultType)
            return cell
        }else if indexPath.section == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: TwoButtonTableViewCell.identifier, for: indexPath) as! TwoButtonTableViewCell
            cell.setButtonTitles(leftBtnTitle: "Hediyeleri Dağıt", rightBtnTitle: "Temizle")
            cell.tag = indexPath.section
            cell.delegate = self
            return cell
        }else if indexPath.section == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultTitleTableViewCell.identifier, for: indexPath) as! ResultTitleTableViewCell
            cell.setTitle(text: "Talihliler")
            return cell
        }else if indexPath.section == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: GiftResultTableViewCell.identifier, for: indexPath) as! GiftResultTableViewCell
            cell.setFields(leftText: giftResults[indexPath.row].giftValue, rightText: giftResults[indexPath.row].personName)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension GiftViewController: TwoButtonCellDelegate{
    func leftButtonTapped(tag: Int) {
        if tag == 0 {
            if giftItems.count == fieldItems.count {
                let alert = UIAlertController(title: "Uyarı", message: "Hediye sayısı kişi sayısından fazla olamaz", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }else{
                let newId = self.giftItems.last!.id + 1
                self.giftItems.append(InputModel(id: newId, value: ""))
                self.giftTableView.beginUpdates()
                let selectedIndexPath = IndexPath(item:newId-1 , section: 1)
                self.giftTableView.insertRows(at: [selectedIndexPath], with: .automatic)
                self.giftTableView.endUpdates()
                
            }
        }else if tag == 2{
            let newId = self.fieldItems.last!.id + 1
            self.fieldItems.append(InputModel(id: newId, value: ""))
            self.giftTableView.beginUpdates()
            let selectedIndexPath = IndexPath(item:newId-1 , section: 3)
            self.giftTableView.insertRows(at: [selectedIndexPath], with: .automatic)
            self.giftTableView.endUpdates()
        }else if tag == 4{
            distributeGifts()
        }
    }
    
    func rightButtonTapped(tag: Int) {
        if tag == 0 {
            if giftItems.count > 1 {
                self.giftItems.popLast()
                self.giftTableView.beginUpdates()
                let selectedIndexPath = IndexPath(item:self.giftItems.count , section: 1)
                self.giftTableView.deleteRows(at: [selectedIndexPath], with: .fade)
                self.giftTableView.endUpdates()
            }else{
                let alert = UIAlertController(title: "Uyarı", message: "Hediye sayısı 1'den az olamaz", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }else if tag == 2{
            if fieldItems.count > 2{
                if giftItems.count == fieldItems.count {
                    let alert = UIAlertController(title: "Uyarı", message: "Kişi sayısı hediye sayısından az olamaz", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }else{
                    self.fieldItems.popLast()
                    self.giftTableView.beginUpdates()
                    let selectedIndexPath = IndexPath(item:self.fieldItems.count , section: 3)
                    self.giftTableView.deleteRows(at: [selectedIndexPath], with: .fade)
                    self.giftTableView.endUpdates()
                }
            }else{
                let alert = UIAlertController(title: "Uyarı", message: "Kişi sayısı 2'den az olamaz", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
        }else if tag == 4{
            cleanPage()
        }
    }
    
    
}
