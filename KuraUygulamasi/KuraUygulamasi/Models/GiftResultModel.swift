//
//  GiftResultModel.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 20.01.2022.
//

import Foundation

struct GiftResultModel {
    
    init(id:Int, giftValue:String, personName:String) {
        self.id = id
        self.giftValue = giftValue
        self.personName = personName
    }
    
    init(id:Int, giftValue:String) {
        self.id = id
        self.giftValue = giftValue
        self.personName = ""
    }

    var id : Int
    var giftValue : String
    var personName : String
}
