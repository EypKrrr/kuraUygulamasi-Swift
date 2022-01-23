//
//  InputModel.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 6.10.2021.
//

import Foundation

struct InputModel {
    init(id:Int, value: String) {
        self.id = id
        self.value = value
    }
    
    var id : Int
    var value : String
}
