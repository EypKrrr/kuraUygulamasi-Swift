//
//  MainPageMenuHelper.swift
//  Second
//
//  Created by Eyup KORURER on 22.09.2021.
//

import Foundation
import UIKit

enum MainPageMenuType : Int {
    case sirayaSokma, takimalaraAyirma, cekilis
    
    var title:String {
        switch self {
        case .sirayaSokma: return "Sıraya Sokma"
        case .takimalaraAyirma: return "Takımlara Ayırma"
        case .cekilis: return "Çekiliş"
        }
    }
    
    var iamgeName:String {
        switch self {
        case .sirayaSokma: return "sortIcon"
        case .takimalaraAyirma: return "teamIcon"
        case .cekilis: return "lottery"
        }
    }
    
    var toVC : UIViewController{
        switch self {
        case .sirayaSokma: return getSirayaSokmaVC()
        case .takimalaraAyirma: return getTakimlaraAyirmaVC()
        case .cekilis: return getCekilisVC()
        }
    }
}

extension MainPageMenuType {
    func getSirayaSokmaVC() -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "SortVC") as? SortViewController
        VC?.title = self.title
        return VC ?? UIViewController()
    }
    
    func getTakimlaraAyirmaVC() -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "TeamsVC") as? TeamsViewController
        VC?.title = self.title
        return VC ?? UIViewController()
    }
    
    func getCekilisVC() -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "GiftVC") as? GiftViewController
        VC?.title = self.title
        return VC ?? UIViewController()
    }
}

class MainPageMenuHelper : NSObject {
    static let menuItems : [MainPageMenuType] = [.sirayaSokma, .takimalaraAyirma, .cekilis]
}
