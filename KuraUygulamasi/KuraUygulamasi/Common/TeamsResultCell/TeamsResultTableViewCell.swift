//
//  TeamsResultTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 28.12.2021.
//

import UIKit

class TeamsResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var innerTableView: SelfSizedTableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    

    
    static let identifier = "TeamsResultTableViewCell"
    let team = ". Takım"

    var teamMembers : [ResultModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func fillCell(currentTeam: TeamsResultModel) {
        cellTitle.text = "\(currentTeam.teamId)" + team
        self.teamMembers = currentTeam.members
        
        
        innerTableView.delegate = self
        innerTableView.dataSource = self
        innerTableView.selfSizedDelegate = self
        
        let teamsResultInnerCell = UINib(nibName: TeamsResultInnerTableViewCell.identifier, bundle: nil)
        innerTableView.register(teamsResultInnerCell, forCellReuseIdentifier: TeamsResultInnerTableViewCell.identifier)
        
        innerTableView.reloadData()
    }
    
}

extension TeamsResultTableViewCell: UITableViewDelegate, UITableViewDataSource, SelfSizedTableViewDelegate {
    func reloadTrigger(tag: Int) {
        tableViewHeight.constant = CGFloat(30 + (20 * (self.teamMembers?.count ?? 0)))
    }
    
    func endUpdateTrigger(tag: Int) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.teamMembers?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamsResultInnerTableViewCell.identifier, for: indexPath) as? TeamsResultInnerTableViewCell
        cell?.fillCell(contentString: self.teamMembers?[indexPath.row].value ?? "")
        return cell ?? UITableViewCell()
    }


}
