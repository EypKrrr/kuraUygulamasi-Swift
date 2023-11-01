//
//  TeamsResultTableViewCell.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 28.12.2021.
//

import UIKit

final class TeamsResultTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var cellTitle: UILabel!
    @IBOutlet private weak var innerTableView: SelfSizedTableView!
    
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
        teamMembers = currentTeam.members
        
        innerTableView.delegate = self
        innerTableView.dataSource = self
        
        let teamsResultInnerCell = UINib(nibName: TeamsResultInnerTableViewCell.nameOfClass, bundle: nil)
        innerTableView.register(teamsResultInnerCell, forCellReuseIdentifier: TeamsResultInnerTableViewCell.nameOfClass)
        
        innerTableView.reloadData()
    }
    
}

extension TeamsResultTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teamMembers?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamsResultInnerTableViewCell.nameOfClass, for: indexPath) as? TeamsResultInnerTableViewCell
        cell?.fillCell(contentString: teamMembers?[safe: indexPath.row]?.value ?? "")
        return cell ?? UITableViewCell()
    }
}
