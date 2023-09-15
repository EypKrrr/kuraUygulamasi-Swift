//
//  TeamsResultModel.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 28.12.2021.
//

import Foundation

struct TeamsResultModel {
    init(id:Int, memberList:[ResultModel]) {
        self.teamId = id
        self.members = memberList
    }
    
    init() {
        self.teamId = -1
        self.members = []
    }
    
    var teamId : Int
    var members : [ResultModel]
}
