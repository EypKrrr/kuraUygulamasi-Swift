//
//  BaseViewController.swift
//  KuraUygulamasi
//
//  Created by Eyup KORURER on 23.01.2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showAlert(title: String?, message: String?, buttonTitle: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
