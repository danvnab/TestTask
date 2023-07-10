//
//  Extension.swift
//  TestTask
//
//  Created by Danil Velanskiy on 10.07.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(messege: String) {
        let alert = UIAlertController(title: "error", message: messege, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
