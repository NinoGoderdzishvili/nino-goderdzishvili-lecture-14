//
//  Alert.swift
//  nino goderdzishvili lecture 14
//
//  Created by Nino Goderdzishvili on 11/24/22.
//

import Foundation
import UIKit

class Alert {
    func showAlert(title: String? = nil, message: String? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        return alert
    }
}
