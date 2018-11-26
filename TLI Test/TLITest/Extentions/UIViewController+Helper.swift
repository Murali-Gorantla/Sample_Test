//
//  UIViewController+Helper.swift
//  SkyCoreTest
//
//  Created by Murali Gorantla on 02/11/18.
//  Copyright © 2018 Murali Gorantla. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
