//
//  ResultModel.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 28.12.2021.
//

import Foundation

struct ResultModel {
    init(id:Int, value: String) {
        self.id = id
        self.value = value
    }
    
    var id : Int
    var value : String
}
