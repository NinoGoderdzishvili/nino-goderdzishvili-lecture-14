//
//  PersonCV.swift
//  nino goderdzishvili lecture 14
//
//  Created by Nino Goderdzishvili on 11/23/22.
//

import UIKit

class PersonCV: UITableViewCell {
    
    var parentVC: UIViewController!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func showName(_ sender: Any) {
        let alert = Alert()
        parentVC.present(alert.showAlert(message: firstNameLabel.text!), animated: true, completion: nil)
    }
    
    
    @IBAction func showAge(_ sender: Any) {
        let alert = Alert()
        parentVC.present(alert.showAlert(message: ageLabel.text!), animated: true, completion: nil)
    }
}
