//
//  SortViewController.swift
//  Second
//
//  Created by Eyup KORURER on 23.09.2021.
//

import UIKit


class SortViewController: BaseViewController {
    
    @IBOutlet weak var sortTableView: UITableView!
    
    
    var inputItems : [InputModel] = []
    var resultItems : [InputModel] = []
    private var resultShouldVisable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputItems.append(InputModel(id: 1, value: ""))
        inputItems.append(InputModel(id: 2, value: ""))
        
        initVC()
        addRightBarButton()
    }
    
    func addRightBarButton() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 24, height: 24)
        menuBtn.setImage(UIImage(named:"saveIcon"), for: .normal)
        menuBtn.addTarget(self, action: #selector(rightBarButtonTapped), for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
    
    @objc func rightBarButtonTapped(){
        print("Save menu icon tapped")
    }
    
    func initVC() {
        
        sortTableView.delegate = self
        sortTableView.dataSource = self
        
        let twoButtonCell = UINib(nibName: TwoButtonTableViewCell.identifier, bundle: nil)
        sortTableView.register(twoButtonCell, forCellReuseIdentifier: TwoButtonTableViewCell.identifier)
        
        let inputCell = UINib(nibName: InputTableViewCell.identifier, bundle: nil)
        sortTableView.register(inputCell, forCellReuseIdentifier: InputTableViewCell.identifier)
        
        let resultTitleCell = UINib(nibName: ResultTitleTableViewCell.identifier, bundle: nil)
        sortTableView.register(resultTitleCell, forCellReuseIdentifier: ResultTitleTableViewCell.identifier)
        
        let resultCell = UINib(nibName: SortResultTableViewCell.identifier, bundle: nil)
        sortTableView.register(resultCell, forCellReuseIdentifier: SortResultTableViewCell.identifier)

    }
    
    func orderAction() {
        for item in inputItems {
            let indexPath = IndexPath(row: item.id - 1, section: 1)
            let multilineCell = sortTableView.cellForRow(at: indexPath) as! InputTableViewCell
            if multilineCell.input.text ?? "" != ""{
                inputItems[item.id - 1].value = multilineCell.input.text ?? ""
            }else{
                let alert = UIAlertController(title: "Uyarı", message: "\(item.id). Alan boş", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
                
            }
        }
        resultItems = inputItems.shuffled()
        orderResultNumbers()
        
        if !resultShouldVisable {
            resultShouldVisable = true
        }
        
        insertResultRows()
    }
    
    func orderResultNumbers() {
        for (index, _) in resultItems.enumerated() {
            resultItems[index].id = index + 1
        }
    }
    
    func insertResultRows(){
        if sortTableView.numberOfSections == 3{
            let indexSet = IndexSet(integersIn: 3...4)
            sortTableView.insertSections(indexSet, with: .automatic)
        }else{
            let indexSet = IndexSet(integer: 4)
            sortTableView.reloadSections(indexSet, with: .automatic)
        }
        let resultTitleIndex = IndexPath(item: 0, section: 3)
        sortTableView.scrollToRow(at: resultTitleIndex, at: .middle, animated: true)
    }
    
    func cleanPage(){
        resultShouldVisable = false
        
        inputItems.removeAll()
        resultItems.removeAll()
        
        inputItems.append(InputModel(id: 1, value: ""))
        inputItems.append(InputModel(id: 2, value: ""))
        
        sortTableView.reloadData()
    }
    
}

//Tableview Delegate methods
extension SortViewController :UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if resultShouldVisable{
            return 5
        }else{
            return 3
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
            let cell = tableView.dequeueReusableCell(withIdentifier: TwoButtonTableViewCell.identifier, for: indexPath) as! TwoButtonTableViewCell
            cell.setButtonTitles(leftBtnTitle: "Sıraya Sok", rightBtnTitle: "Temizle")
            cell.tag = indexPath.section
            cell.delegate = self
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultTitleTableViewCell.identifier, for: indexPath) as! ResultTitleTableViewCell
            cell.setTitle(text: "Sıralama")
            return cell
        }else if indexPath.section == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: SortResultTableViewCell.identifier, for: indexPath) as! SortResultTableViewCell
            cell.setLabels(queText: resultItems[indexPath.row].id, descriptionText: resultItems[indexPath.row].value)
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension SortViewController: TwoButtonCellDelegate{
    func leftButtonTapped(tag: Int) {
        if tag == 0{
            let newId = self.inputItems.last!.id + 1
            self.inputItems.append(InputModel(id: newId, value: ""))
            self.sortTableView.beginUpdates()
            let selectedIndexPath = IndexPath(item:newId-1 , section: 1)
            self.sortTableView.insertRows(at: [selectedIndexPath], with: .automatic)
            self.sortTableView.endUpdates()
        }else if tag == 2{
            orderAction()
        }
    }
    
    func rightButtonTapped(tag: Int) {
        if tag == 0{
            if inputItems.count > 2 {
                self.inputItems.popLast()
                self.sortTableView.beginUpdates()
                let selectedIndexPath = IndexPath(item:self.inputItems.count , section: 1)
                self.sortTableView.deleteRows(at: [selectedIndexPath], with: .fade)
                self.sortTableView.endUpdates()
            }else{
                let alert = UIAlertController(title: "Uyarı", message: "Alan sayısı 1'den az olamaz", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }else if tag == 2{
            cleanPage()
        }
    }
}
