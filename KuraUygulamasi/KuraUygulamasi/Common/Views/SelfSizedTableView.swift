//
//  SelfSizedTableView.swift
//  Second
//
//  Created by Eyup KORURER on 23.09.2021.
//

import UIKit

class SelfSizedTableView : UITableView {
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
