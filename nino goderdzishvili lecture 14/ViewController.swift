//
//  ViewController.swift
//  nino goderdzishvili lecture 14
//
//  Created by Nino Goderdzishvili on 11/22/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var alert: Alert = Alert()
    var persons: [Person] = []
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    
    @IBOutlet weak var personsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupPersonsTV()
        setupTextFields()
    }
    
    func setupPersonsTV() {
        personsTV.delegate = self
        personsTV.dataSource = self
    }
    
    func setupTextFields() {
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        ageTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addPersonBtn(_ sender: Any) {
        if firstNameTF.text == "" || lastNameTF.text == "" || ageTF.text == "" {
            present(
                alert.showAlert(title: "შეცდომა", message: "შეიყვანეთ ყველა მონაცემი"),
                    animated: true, completion: nil)
        } else if(UInt(ageTF.text!)! <= 0) {
            present(
                alert.showAlert(title: "შეცდომა", message: "ასაკი არასწორია"),
                    animated: true, completion: nil)
        } else {
            addPerson()
        }
    }
    
    func addPerson() {
        let firstName = firstNameTF.text!
        let lastName = lastNameTF.text!
        let age = UInt(ageTF.text!)!
        
        let person = Person(firstName: firstName, lastName: lastName, age: age)
        persons.append(person)
        
        personsTV.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCV", for: indexPath) as?
                PersonCV else {
            return UITableViewCell()
        }
        
        cell.parentVC = self
        
        let currentPerson = persons[indexPath.row]
        cell.firstNameLabel.text = "სახელი: \(currentPerson.firstName)"
        cell.lastNameLabel.text = "გვარი: \(currentPerson.lastName)"
        cell.ageLabel.text = "ასაკი: \(currentPerson.age)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
