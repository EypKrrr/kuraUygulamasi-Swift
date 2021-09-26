//
//  MainPageMenuHelper.swift
//  Second
//
//  Created by Eyup KORURER on 22.09.2021.
//

import Foundation
import UIKit

enum MainPageMenuType : Int {
    case sirayaSokma, takimalaraAyirma
    
    var title:String {
        switch self {
        case .sirayaSokma: return "Sıraya Sokma"
        case .takimalaraAyirma: return "Takımlara Ayırma"
        }
    }
    
    var iamgeName:String {
        switch self {
        case .sirayaSokma: return "sortIcon"
        case .takimalaraAyirma: return "sortIcon"
        }
    }
    
    var toVC : UIViewController{
        switch self {
        case .sirayaSokma: return getSirayaSokmaVC()
        case .takimalaraAyirma: return getSirayaSokmaVC()
        }
    }
}

extension MainPageMenuType {
    func getSirayaSokmaVC() -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "SortVC")
    }
}

class MainPageMenuHelper : NSObject {
    static let menuItems : [MainPageMenuType] = [.sirayaSokma, .takimalaraAyirma]
}
