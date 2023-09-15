//
//  UIFont+Ext.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 13.03.2022.
//

import UIKit

extension UIFont {
    
    class func HelveticaNeueRegularWith(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    class func HelveticaNeueThinWith(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Thin", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    class func HelveticaNeueMediumWith(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
