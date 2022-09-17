//
//  ViewController+Ext.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 13.09.2022.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(button)
        navigationController?.present(alert, animated: true)
    }
}
