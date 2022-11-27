//
//  ViewController.swift
//  nino goderdzishvili lecture 14
//
//  Created by Nino Goderdzishvili on 11/22/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var alert: Alert = Alert()
    
    var allPersons: [[Person]] = [[]]
    
    var georgainPersons: [Person] = []
    var spanishPersons: [Person] = []
    var italianPersons: [Person] = []
    var frenchPersons: [Person] = []
    
    var personsUnder_18: [Person] = []
    var personsOver_18: [Person] = []
    
    var isSortedByAge = false
    var isSortedByCountry = false
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var nationalityTF: UITextField!
    
    @IBOutlet weak var adultOrOverAgeTF: UITextField!
    
    @IBOutlet weak var countryTF: UITextField!
    
    @IBOutlet weak var personsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupPersonsTV()
        setupTextFields()
        createPersons()
    }
    
    func fillPersonsByAge() {
        personsUnder_18.removeAll()
        personsOver_18.removeAll()
        
        for persons in allPersons {
            for person in persons {
                if person.age > 18 {
                    personsOver_18.append(person)
                } else {
                    personsUnder_18.append(person)
                }
            }
        }
    }
    
    func createPersons() {
        
        georgainPersons.append(Person(firstName: "გიორგი",
                                      lastName: "ხუციშვილი",
                                      age: 31,
                                      nationality: Nationality.georgian.rawValue,
                                      country: Country.georgia.rawValue))
        
        georgainPersons.append(Person(firstName: "დავით",
                                      lastName: "აღაპიშვილი",
                                      age: 50, nationality: Nationality.georgian.rawValue,
                                      country: Country.georgia.rawValue))
        
        georgainPersons.append(Person(firstName: "მარიამ",
                                      lastName: "ნადირაძე",
                                      age: 17,
                                      nationality: Nationality.georgian.rawValue,
                                      country: Country.georgia.rawValue))
        
        spanishPersons.append(Person(firstName: "სერხიო",
                                     lastName: "რამოსი",
                                     age: 35,
                                     nationality: Nationality.spanish.rawValue,
                                     country: Country.spain.rawValue))
        
        spanishPersons.append(Person(firstName: "ხუან",
                                     lastName: "დელგადო",
                                     age: 15,
                                     nationality: Nationality.spanish.rawValue,
                                     country: Country.spain.rawValue))
        
        italianPersons.append(Person(firstName: "ნინო",
                                     lastName: "როტა",
                                     age: 20,
                                     nationality: Nationality.italian.rawValue,
                                     country: Country.italy.rawValue))
        
        italianPersons.append(Person(firstName: "მარიო",
                                     lastName: "პიუზო",
                                     age: 90,
                                     nationality: Nationality.italian.rawValue,
                                     country: Country.italy.rawValue))
        
        frenchPersons.append(Person(firstName: "ალფრედ",
                                    lastName: "გოტიე",
                                    age: 2,
                                    nationality: Nationality.french.rawValue,
                                    country: Country.france.rawValue))
        
        frenchPersons.append(Person(firstName: "იზაბელ",
                                    lastName: "ჟუბერტი",
                                    age: 25,
                                    nationality: Nationality.french.rawValue,
                                    country: Country.france.rawValue))
        
        frenchPersons.append(Person(firstName: "ნიკოლ",
                                    lastName: "ლავინი",
                                    age: 13,
                                    nationality: Nationality.french.rawValue,
                                    country: Country.france.rawValue))
        
        allPersons.append(georgainPersons)
        allPersons.append(spanishPersons)
        allPersons.append(italianPersons)
        allPersons.append(frenchPersons)
        
        fillPersonsByAge()
    }
    
    func setupPersonsTV() {
        personsTV.delegate = self
        personsTV.dataSource = self
    }
    
    func setupTextFields() {
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        ageTF.delegate = self
        nationalityTF.delegate = self
    }
    
    @IBAction func sortByAge(_ sender: Any) {
        isSortedByAge.toggle()
        personsTV.reloadData()
    }
    
    @IBAction func sortByCountry(_ sender: Any) {
        
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        
        let persons = allPersons.flatMap { $0 }
        
        if adultOrOverAgeTF.text != "" {
            
            let adultOrOverAge = adultOrOverAgeTF.text!
            
            if adultOrOverAge == "არასრულწლოვანი" {
                let personsUnder_18 = persons.filter { person in
                    return person.age < 18
                }
                
                allPersons.append(personsUnder_18)
            }
            
            if adultOrOverAge == "სრულწლოვანი" {
                
                let personsOver_18 = persons.filter { person in
                    return person.age > 18
                }
                
                allPersons.append(personsOver_18)
            }
        }
        
        if countryTF.text != "" {
            let country = countryTF.text!
            
            let personsByCountry = persons.filter { person in
                return person.nationality.contains(country)
            }
            
            allPersons.append(personsByCountry)
        }
        
        personsTV.reloadData()
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
        let nationality = nationalityTF.text!
        
        var person = Person(firstName: firstName, lastName: lastName, age: age, nationality: nationality)
        
        if person.nationality == Nationality.georgian.rawValue {
            person.country = Country.georgia.rawValue
            georgainPersons.append(person)
            allPersons.append(georgainPersons)
        }
        
        if person.nationality == Nationality.spanish.rawValue {
            person.country = Country.spain.rawValue
            spanishPersons.append(person)
            allPersons.append(spanishPersons)
        }
        
        if person.nationality == Nationality.italian.rawValue {
            person.country = Country.italy.rawValue
            italianPersons.append(person)
            allPersons.append(italianPersons)
        }
        
        if person.nationality == Nationality.french.rawValue {
            person.country = Country.france.rawValue
            frenchPersons.append(person)
            allPersons.append(frenchPersons)
        }
        
        personsTV.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSortedByAge {
            return 2
        } else {
            return allPersons.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(section)
        if isSortedByAge {
            if section == 0 {
                return personsUnder_18.count
            } else {
                return personsUnder_18.count
            }
        } else {
            let persons = allPersons[section]
            return persons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCV", for: indexPath) as?
                PersonCV else {
            return UITableViewCell()
        }
        
        cell.parentVC = self
        
        var currentPerson: Person
        
        let personsArray = allPersons[indexPath.section]
        
        if isSortedByAge {
            if indexPath.section == 0 {
                currentPerson = personsUnder_18[indexPath.row]
            } else {
                currentPerson = personsOver_18[indexPath.row]
            }
        } else {
            currentPerson = personsArray[indexPath.row]
        }
        
        cell.firstNameLabel.text = "სხელი: \(currentPerson.firstName)"
        cell.lastNameLabel.text = "გვარი: \(currentPerson.lastName)"
        cell.ageLabel.text = "ასაკი: \(currentPerson.age)"
        cell.nationalityLabel.text = "ეროვნება: \(currentPerson.nationality)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        let boldAttribute = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 16.0)!]
        let boldText = NSAttributedString(string: "Persons", attributes: boldAttribute)
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(boldText)
        
        label.attributedText = attributedText
        
        let personsArray = allPersons[section]
        let person = personsArray.first
        
        let georgian = Nationality.georgian.rawValue
        let spanish = Nationality.spanish.rawValue
        let italian = Nationality.italian.rawValue
        let french = Nationality.french.rawValue
        
        if isSortedByAge {
            if section == 0 {
                label.text = "არასრულწლოვანი:"
            } else {
                label.text =  "სრულწლოვანი:"
            }
        } else {
            if person?.nationality == georgian {
                label.text = "საქართველო:"
            }
            
            if person?.nationality == spanish {
                label.text = "ესპანეთი:"
            }
            
            if person?.nationality == italian {
                label.text = "იტალია:"
            }
            
            if person?.nationality == french {
                label.text = "საფრანგეთი:"
            }
        }
        
        return label
    }
}
