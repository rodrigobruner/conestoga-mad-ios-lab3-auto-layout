//
//  ViewController.swift
//  auto-layout
//
//  Created by user249117 on 5/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var surname: UITextField!
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var dateOfBirth: UITextField!
    
    @IBOutlet weak var contract: UITextView!
    
    @IBOutlet weak var btnResetOutlet: UIButton!
    
    @IBOutlet weak var btnDeclineOutlet: UIButton!
    
    @IBOutlet weak var btnAcceptOutlet: UIButton!
    
    let datePicker = UIDatePicker()
    
    var age=0;
    
    var isValidForm:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup afte loading the view.
        
        createDatepicker()
        updateContract()
    }
    

    @IBAction func fieldName(_ sender: Any) {
        updateContract()
    }
    
    
    @IBAction func fieldSurname(_ sender: Any) {
        updateContract()
    }
    
    
    @IBAction func fieldAddress(_ sender: Any) {
        updateContract()
    }
    
    
    @IBAction func fieldCity(_ sender: Any) {
        updateContract()
    }
    
    
    func updateContract(){
        
        disableButtons()
        contract.textColor = UIColor.gray
        contract.text = "Please fill in all the fields above."
        
        if (age < 18 && age > 0) {
            contract.textColor = UIColor.red
            contract.text = "🔞 You must be over 18 to accept these terms."
        }
        
        validFields()
        if self.isValidForm {
            contract.textColor = UIColor.black
            contract.text = "I, \(name.text!), \(surname.text!), currently living at \(address.text!) in the city of \(city.text!) do hereby accept the terms and conditions assignment. \n\nI am \(age) and therefore am able to accept the conditions of this assignment."
            enableButtons()
        }
    }
    
    func validFields() {
        self.isValidForm = false
        if (name.text != ""
            && surname.text != ""
            && address.text != ""
            && city.text != ""
            && age >= 18) {

            self.isValidForm = true
        }
    }
    
    func enableButtons(){
        btnResetOutlet.isEnabled = true
        btnDeclineOutlet.isEnabled = true;
        btnAcceptOutlet.isEnabled = true;
    }
    
    func disableButtons(){
        btnResetOutlet.isEnabled = false
        btnDeclineOutlet.isEnabled = false;
        btnAcceptOutlet.isEnabled = false;
    }

    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([btnDone], animated: true)
        
        return toolbar
    }
    
    func createDatepicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dateOfBirth.inputView = datePicker
        dateOfBirth.inputAccessoryView = createToolbar()
    }
    
    @objc func donePressed() {
        let dataFormatter = DateFormatter()
        dataFormatter.dateStyle = .medium
        dataFormatter.timeStyle = .none
        
        self.dateOfBirth.text = dataFormatter.string(from: datePicker.date)
        calcAge()
        self.view.endEditing(true)
    }
    
    func calcAge(){
        let now = Date()
        let birthday: Date = datePicker.date
        let calendar = Calendar.current
        
        let ageCalc = calendar.dateComponents([.year], from: birthday, to: now)
        self.age = ageCalc.year!

        updateContract()
    }
    
    
    
    @IBAction func btnReset(_ sender: Any) {
        name.text=""
        name.isEnabled=true
        surname.text=""
        surname.isEnabled=true
        address.text=""
        address.isEnabled=true
        city.text=""
        city.isEnabled=true
        dateOfBirth.text=""
        dateOfBirth.isEnabled=true
        
        updateContract()
    }
    
    
    @IBAction func btnDecline(_ sender: Any) {
        validFields()
        if self.isValidForm {
            contract.textColor = UIColor.red
            contract.text = "⛔️ You did not accept the terms!\n\n\nFor new registration press the Reset button."
            disableButtons()
            btnResetOutlet.isEnabled = true
        }
    }
    
    
    @IBAction func btnAccept(_ sender: Any) {
        validFields()
        if self.isValidForm {
            contract.textColor = UIColor.green
            contract.text = "✅ Thank you for accepting the terms, we will be in touch shortly.\n\n\nFor a new registration press the Reset button."
            disableButtons()
            name.isEnabled=false
            surname.isEnabled=false
            address.isEnabled=false
            city.isEnabled=false
            dateOfBirth.isEnabled=false
            btnResetOutlet.isEnabled=true
        }
    }
    
}

