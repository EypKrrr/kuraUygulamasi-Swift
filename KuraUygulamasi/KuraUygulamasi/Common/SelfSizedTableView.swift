//
//  SelfSizedTableView.swift
//  Second
//
//  Created by Eyup KORURER on 23.09.2021.
//

import Foundation
import UIKit

protocol SelfSizedTableViewDelegate : NSObject {
    func reloadTrigger(tag:Int)
    func endUpdateTrigger(tag:Int)
}

class SelfSizedTableView : UITableView {
    
    var selfSizedDelegate : SelfSizedTableViewDelegate?
    
    override func reloadData() {
        super.reloadData()
//        self.heightAnchor.constraint(equalToConstant: self.contentSize.height)
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
        selfSizedDelegate?.reloadTrigger(tag: self.tag)
    }
    
    override func endUpdates() {
        super.endUpdates()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
        selfSizedDelegate?.endUpdateTrigger(tag: self.tag)
    }
}
