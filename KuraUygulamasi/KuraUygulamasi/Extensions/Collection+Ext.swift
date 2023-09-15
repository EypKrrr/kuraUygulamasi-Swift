//
//  Collection+Ext.swift
//  KuraUygulamasi
//
//  Created by Eyüp KORURER on 13.09.2023.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
}
