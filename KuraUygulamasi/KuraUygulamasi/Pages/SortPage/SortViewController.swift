//
//  SortViewController.swift
//  Second
//
//  Created by Eyup KORURER on 23.09.2021.
//

import UIKit


class SortViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    enum TableSection: Int {
        case input
        case twoButton
        case resultTitle
        case result
    }
    
    var inputItems : [InputModel] = []
    var resultItems : [InputModel] = []
    private var resultShouldVisable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftBarButton()
        addRightBarButton()
        inputItems.append(InputModel(id: 1, value: ""))
        inputItems.append(InputModel(id: 2, value: ""))
        initVC()
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let twoButtonCell = UINib(nibName: TwoButtonTableViewCell.identifier, bundle: nil)
        tableView.register(twoButtonCell, forCellReuseIdentifier: TwoButtonTableViewCell.identifier)
        
        let inputCell = UINib(nibName: InputTableViewCell.identifier, bundle: nil)
        tableView.register(inputCell, forCellReuseIdentifier: InputTableViewCell.identifier)
        
        let resultTitleCell = UINib(nibName: ResultTitleTableViewCell.identifier, bundle: nil)
        tableView.register(resultTitleCell, forCellReuseIdentifier: ResultTitleTableViewCell.identifier)
        
        let resultCell = UINib(nibName: SortResultTableViewCell.identifier, bundle: nil)
        tableView.register(resultCell, forCellReuseIdentifier: SortResultTableViewCell.identifier)

    }
    
    func orderAction() {
        for item in inputItems {
            let indexPath = IndexPath(row: item.id - 1, section: TableSection.input.rawValue)
            let multilineCell = tableView.cellForRow(at: indexPath) as! InputTableViewCell
            if multilineCell.input.text ?? "" != ""{
                inputItems[item.id - 1].value = multilineCell.input.text ?? ""
            }else{
                showAlert(title: "Uyar??", message: "\(item.id). Alan bo??", buttonTitle: "Tamam", handler: nil)
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
        if self.tableView.numberOfSections == 2{
            let indexSet = IndexSet(integersIn: TableSection.resultTitle.rawValue...TableSection.result.rawValue)
            self.tableView.insertSections(indexSet, with: .automatic)
        }else{
            let indexSet = IndexSet(integer: TableSection.result.rawValue)
            self.tableView.reloadSections(indexSet, with: .automatic)
        }
        let resultTitleIndex = IndexPath(item: 0, section: TableSection.resultTitle.rawValue)
        self.tableView.scrollToRow(at: resultTitleIndex, at: .middle, animated: true)
    }
    
    func cleanPage(){
        resultShouldVisable = false
        
        inputItems.removeAll()
        resultItems.removeAll()
        
        inputItems.append(InputModel(id: 1, value: ""))
        inputItems.append(InputModel(id: 2, value: ""))
        
        self.tableView.reloadData()
    }
}

//Tableview Delegate methods
extension SortViewController :UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if resultShouldVisable{
            return 4
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TableSection.input.rawValue{
            return inputItems.count
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
        }else if indexPath.section == TableSection.twoButton.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: TwoButtonTableViewCell.identifier, for: indexPath) as! TwoButtonTableViewCell
            cell.setButtonTitles(leftBtnTitle: "Yeni Ki??i Ekle", rightBtnTitle: "S??raya Sok")
            cell.tag = indexPath.section
            cell.delegate = self
            return cell
        }else if indexPath.section == TableSection.resultTitle.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultTitleTableViewCell.identifier, for: indexPath) as! ResultTitleTableViewCell
            cell.setTitle(text: "S??ralama")
            return cell
        }else if indexPath.section == TableSection.result.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: SortResultTableViewCell.identifier, for: indexPath) as! SortResultTableViewCell
            cell.setLabels(queText: resultItems[indexPath.row].id, descriptionText: resultItems[indexPath.row].value)
            return cell
        }
        return UITableViewCell()
    }
}

extension SortViewController: TwoButtonCellDelegate{
    func leftButtonTapped(tag: Int) {
        if tag == TableSection.twoButton.rawValue{
            let newId = self.inputItems.last!.id + 1
            self.inputItems.append(InputModel(id: newId, value: ""))
            self.tableView.beginUpdates()
            let selectedIndexPath = IndexPath(item:newId-1 , section: TableSection.input.rawValue)
            self.tableView.insertRows(at: [selectedIndexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    func rightButtonTapped(tag: Int) {
        if tag == TableSection.twoButton.rawValue{
            orderAction()
        }
    }
}

extension SortViewController: InputCellDelegate {
    func trashButtonTapped(row: Int, section: Int){
        if inputItems.count > 2 {
            for (index, item) in inputItems.enumerated() {
                let indexPath = IndexPath(row: item.id - 1, section: section)
                let inputCell = self.tableView.cellForRow(at: indexPath) as! InputTableViewCell
                inputItems[item.id - 1].value = inputCell.input.text ?? ""
                if index >= row {
                    inputItems[index].id -= 1
                }
            }
            inputItems.remove(at: row)
            
            let indexSet = IndexSet(integer: section)
            self.tableView.reloadSections(indexSet, with: .automatic)
        }else{
            showAlert(title: "Uyar??", message: "Ki??i say??s?? 2'den az olamaz", buttonTitle: "Tamam", handler: nil)
            return
        }
    }
}
