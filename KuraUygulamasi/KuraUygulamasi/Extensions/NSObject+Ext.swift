//
//  NSObject+Ext.swift
//  KuraUygulamasi
//
//  Created by Eyüp KORURER on 13.09.2023.
//

import Foundation

extension NSObject {
    
    class var nameOfClass: String {
        return String(describing: self)
    }
}
