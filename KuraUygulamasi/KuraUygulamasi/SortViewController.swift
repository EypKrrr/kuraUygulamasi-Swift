//
//  SortViewController.swift
//  Second
//
//  Created by Eyup KORURER on 23.09.2021.
//

import UIKit


class SortViewController: UIViewController {
    @IBOutlet weak var addNewAreaBtn: UIButton!
    @IBOutlet weak var removeAreaBtn: UIButton!
    @IBOutlet weak var inputTableviewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var inputTableview: SelfSizedTableView! {
        didSet{
            inputTableview.invalidateIntrinsicContentSize()
            inputTableview.layoutIfNeeded()
        }
    }
    
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var saveListBtn: UIButton!
    @IBOutlet weak var resultTitleLbl: UILabel!
    @IBOutlet weak var resultTableviewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var resultTableview: SelfSizedTableView!{
        didSet{
            resultTableview.invalidateIntrinsicContentSize()
            resultTableview.layoutIfNeeded()
        }
    }
    
    let inputCellSize = 64.5
    let resultCellSize = 64.5
    
    enum Table : Int {
        case input, result
    }
    
    struct InputModel {
        init(id:Int, value: String) {
            self.id = id
            self.value = value
        }
        
        var id : Int
        var value : String
    }
    
    
    var inputItems : [InputModel] = []
    var resultItems : [InputModel] = []
    private var resultShouldVisable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputItems.append(InputModel(id: 1, value: ""))
        inputItems.append(InputModel(id: 2, value: ""))
        
        resultItems.append(InputModel(id: 1, value: ""))
        resultItems.append(InputModel(id: 2, value: ""))

        
        initVC()
        inputTableview.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        inputTableview.reloadData()
    }
    

    
    func initVC() {
        
        inputTableview.tag = Table.input.rawValue
        inputTableview.delegate = self
        inputTableview.dataSource = self
        inputTableview.selfSizedDelegate = self
        
        resultTableview.tag = Table.result.rawValue
        resultTableview.delegate = self
        resultTableview.dataSource = self
        resultTableview.selfSizedDelegate = self
        
        let inputCell = UINib(nibName: InputTableViewCell.identifier, bundle: nil)
        inputTableview.register(inputCell, forCellReuseIdentifier: InputTableViewCell.identifier)
        
        let resultCell = UINib(nibName: SortResultTableViewCell.identifier, bundle: nil)
        resultTableview.register(resultCell, forCellReuseIdentifier: SortResultTableViewCell.identifier)
        
        addNewAreaBtn.setTitle("Yeni Alan Ekle", for: .normal)
        removeAreaBtn.setTitle("Alan Çıkar", for: .normal)
        orderBtn.setTitle("Sıraya Sok", for: .normal)
        saveListBtn.setTitle("Listeye Kaydet", for: .normal)
        
        resultTitleLbl.isHidden = true
        resultTableview.isHidden = true
        
        

    }
    
    func orderAction() {
        for item in inputItems {
            let indexPath = IndexPath(row: item.id - 1, section: 0)
            let multilineCell = inputTableview.cellForRow(at: indexPath) as! InputTableViewCell
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
        resultTableview.reloadData()
        
        if !resultShouldVisable {
            resultShouldVisable = true
            resultTitleLbl.isHidden = false
            resultTableview.isHidden = false
        }
    }
    
    func orderResultNumbers() {
        for (index, item) in resultItems.enumerated() {
            resultItems[index].id = index + 1
        }
    }
    
    
    @IBAction func addNewAreaBtnTapped(_ sender: Any) {
        inputItems.append(InputModel(id: (inputItems.last!.id + 1), value: ""))
        inputTableview.reloadData()
    }
    
    @IBAction func removeAreaBtnTapped(_ sender: Any) {
        if inputItems.count > 2{
            inputItems.popLast()
            inputTableview.reloadData()
        }
    }
    
    @IBAction func orderBtnTapped(_ sender: Any) {
        orderAction()
        
        
    }
    
    @IBAction func saveListBtnTapped(_ sender: Any) {
    }
    
    
}

//Tableview Delegate methods
extension SortViewController :UITableViewDelegate, UITableViewDataSource, SelfSizedTableViewDelegate {
    func reloadTrigger(tag: Int) {
        if tag == Table.input.rawValue {
            inputTableviewHeight.constant = CGFloat(inputCellSize * Double(inputItems.count))
        }else if tag == Table.result.rawValue {
            resultTableviewHeight.constant = CGFloat(resultCellSize * Double(resultItems.count))
        }
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == Table.input.rawValue{
            return inputItems.count
        }else if tableView.tag == Table.result.rawValue{
            return resultItems.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == Table.input.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as! InputTableViewCell
            cell.setLabel(index: inputItems[indexPath.row].id)
            return cell
        }else if tableView.tag == Table.result.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: SortResultTableViewCell.identifier, for: indexPath) as! SortResultTableViewCell
            cell.setLabels(queText: resultItems[indexPath.row].id, descriptionText: resultItems[indexPath.row].value)
            return cell
        }
        
        return UITableViewCell()
    }
    

    
    
}
