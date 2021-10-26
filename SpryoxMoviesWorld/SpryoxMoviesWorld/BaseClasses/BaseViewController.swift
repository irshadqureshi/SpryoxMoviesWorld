//
//  BaseViewController.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = hexStringToUIColor(hex: "#f7f7f7")
    }
    
    public func showAlertMessage(vc: UIViewController, titleStr: String?, messageStr: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        vc.present(alert, animated: true, completion: nil)
    }
}
