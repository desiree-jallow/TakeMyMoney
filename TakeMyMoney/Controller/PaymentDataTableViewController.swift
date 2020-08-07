//
//  PaymentDataTableViewController.swift
//  TakeMyMoney
//
//  Created by Desiree on 7/23/20.
//  Copyright © 2020 Desiree. All rights reserved.
//

import UIKit

class PaymentDataTableViewController: UITableViewController {
    
    @IBOutlet var paypalButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailErrorLabel: UILabel!
    @IBOutlet var passWordTextField: UITextField!
    @IBOutlet var passwordErrorLabel: UILabel!
    
    @IBOutlet var creditButton: UIButton!
    @IBOutlet var cardNumberErrorLabel: UILabel!
    @IBOutlet var cardNumberTextField: UITextField!
    @IBOutlet var cvvNumberErrorLabel: UILabel!
    @IBOutlet var cvvTextField: UITextField!
    @IBOutlet var cardHlderErrorLabel: UILabel!
    @IBOutlet var cardHlderTextField: UITextField!
    @IBOutlet var validTextField: UITextField!
    @IBOutlet var validErrorLabel: UILabel!
    
    @IBOutlet var confirmButton: UIButton!
    
    let creditIndexPath = IndexPath(row: 1, section: 0)
    let paypalIndexPath = IndexPath(row: 2, section: 0)
    
    var cardString = ""
    var cvvString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditButton.isSelected = true
        
        paypalButton.layer.cornerRadius = 8
        creditButton.layer.cornerRadius = 8
        confirmButton.layer.cornerRadius = 8
        paypalButton.backgroundColor = .gray
        
        let datePicker = UIPickerView()
        validTextField.inputView = datePicker
        
        datePicker.delegate = self
        datePicker.dataSource = self
        
        
        emailTextField.delegate = self
        passWordTextField.delegate = self
        cardNumberTextField.delegate = self
        cvvTextField.delegate = self
        cardHlderTextField.delegate = self
        validTextField.delegate = self
        
    }
    
    @IBAction func paypalButtonPressed(_ sender: UIButton) {
        if !paypalButton.isSelected {
            paypalButton.isSelected = true
            paypalButton.backgroundColor = .systemBlue
            creditButton.backgroundColor = .gray
            
        }
        creditButton.isSelected = false
        
        tableView.reloadData()
    }
    
    @IBAction func creditButtonPressed(_ sender: UIButton) {
        if !creditButton.isSelected {
            creditButton.isSelected = true
            creditButton.backgroundColor = .systemBlue
            paypalButton.backgroundColor = .gray
            
        }
        paypalButton.isSelected = false
        
        tableView.reloadData()
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    
    //check all textfields before performing segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "detailSegue" {
            
            let cardNumber = cardNumberTextField.text ?? ""
            let cvvNumber = cvvTextField.text ?? ""
            let cardHolder = cardHlderTextField.text ?? ""
            
            if creditButton.isSelected {
                
                if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: cardString)) || cardNumber.count < 16 {
                    showError(label: cardNumberErrorLabel, textField: cardNumberTextField)
                    cardString = ""
                    return false
                    
                } else {
                    resetField(label: cardNumberErrorLabel, textField: cardNumberTextField)
                }
                
                if validTextField.text == "" {
                    showError(label: validErrorLabel, textField: validTextField)
                    
                    return false
                    
                } else {
                    resetField(label: validErrorLabel, textField: validTextField)
                }
                
                
                if !CharacterSet.decimalDigits.isSuperset(of:CharacterSet(charactersIn: cvvString)) || cvvNumber.count < 3 {
                    showError(label: cvvNumberErrorLabel, textField: cvvTextField)
                    cvvString = ""
                    return false
                    
                } else {
                    resetField(label: cvvNumberErrorLabel, textField: cvvTextField)
                }
                
                if CharacterSet.decimalDigits.isSuperset(of:CharacterSet(charactersIn: cardHolder)) || !isFullName(name: cardHolder) {
                    
                    showError(label: cardHlderErrorLabel, textField: cardHlderTextField)
                    
                    return false
                    
                } else {
                    resetField(label: cardHlderErrorLabel, textField: cardHlderTextField)
                }
                
            }
            if paypalButton.isSelected {
                
                if emailTextField.text == "" {
                    showError(label: emailErrorLabel, textField: emailTextField)
                    
                    return false
                    
                } else {
                    resetField(label: emailErrorLabel, textField: emailTextField)
                }
                if passWordTextField.text == "" {
                    showError(label: passwordErrorLabel, textField: passWordTextField)
                    
                    return false
                    
                } else {
                    resetField(label: passwordErrorLabel, textField: passWordTextField)
                }
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lastFour = String((cardNumberTextField.text?.suffix(4))!)
        if segue.identifier == "detailSegue" {
            let destinationVC = segue.destination as! PaymentDetailViewController
            if creditButton.isSelected {
                destinationVC.image = "mastercard"
                destinationVC.paymentDetail = "Card ending in: \(lastFour)"
                destinationVC.titleInfo = cardHlderTextField.text
            } else if paypalButton.isSelected {
                destinationVC.image = "paypal"
                destinationVC.paymentDetail = emailTextField.text
                destinationVC.titleInfo = "Paypal Credentials"
            }
            
        }
    }
    
    //hide credit cells when paypal button is chosen and paypal cells when credit button is chosen
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 0.0
        
        if indexPath == paypalIndexPath {
            if paypalButton.isSelected {
                height = 176.0
            } else {
                height = 0.0
            }
        } else if indexPath == creditIndexPath {
            if creditButton.isSelected {
                height = 622.0
            } else {
                height = 0.0
            }
        } else {
            height = UITableView.automaticDimension
        }
        
        return height
    }
}
//MARK: - UIPickerViewDelegate
extension PaymentDataTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let years = createYearsArray()
        
        let selectedMonth = "0\(pickerView.selectedRow(inComponent: 0) + 1)"
        let selectedYear = years[pickerView.selectedRow(inComponent: 1)]
        
        validTextField.text = "\(selectedMonth)/\(selectedYear)"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let dateFormatter = DateFormatter()
        let years = createYearsArray()
        
        if component == 0 {
            return dateFormatter.shortMonthSymbols[row]
        } else {
            return years[row]
        }
        
    }
    
    func createYearsArray() -> [String] {
        
        let calender = Calendar.current
        let numberOfYears = 12
        let currentYear = calender.component(.year, from: Date())
        let finalYear = Calendar.current.date(byAdding: .year, value: numberOfYears, to: Date(), wrappingComponents: true)
        let yearInt = calender.component(.year, from: finalYear!)
        let years = (currentYear...yearInt).map {String($0)}
        return years
    }
    
}

//MARK: - UITextFieldDelegate
extension PaymentDataTableViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let cardNumber = cardNumberTextField.text ?? ""
        let cvvNumber = cvvTextField.text ?? ""
        
        if textField == cardNumberTextField {
            // saving cardNumber
            if cardNumber.count < 16 {
                cardString.append(string)
                if string.isEmpty {
                    cardString.removeLast()
                }
            }
            
            guard !string.isEmpty else {
                return true
            }
            
            //replacing the numbers with * except for last 4 and restricting to 16 characters
            if cardNumber.count < 12 {
                cardNumberTextField.text! = "*" + cardNumberTextField.text!
                return false
            } else {
                
                guard let stringRange = Range(range, in: cardNumber) else {return false}
                let updatedText = cardNumber.replacingCharacters(in: stringRange, with: string)
                
                return updatedText.count <= 16
            }
            
        }
        
        
        if textField == cvvTextField {
            // saving cvv number
            if cvvNumber.count < 16 {
                cvvString.append(string)
                if string.isEmpty {
                    cvvString.removeLast()
                }
            }
            
            guard !string.isEmpty else {
                return true
            }
            //replacing the numbers with * and restricting to 3 characters
            if cvvNumber.count < 3 {
                cvvTextField.text! = "*" + cvvTextField.text!
                return false
            } else {
                guard let stringRange = Range(range, in: cvvNumber) else {return false}
                let updatedText = cvvNumber.replacingCharacters(in: stringRange, with: string)
                
                return updatedText.count <= 3
            }
            
        }
        return true
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case cardNumberTextField:
            validTextField.becomeFirstResponder()
        case validTextField:
            cvvTextField.becomeFirstResponder()
        case cvvTextField:
            cardHlderTextField.becomeFirstResponder()
        case emailTextField:
            passWordTextField.becomeFirstResponder()
        default:
            passWordTextField.resignFirstResponder()
        }
        
        return true
    }
    
    func isFullName(name: String) -> Bool {
        let nameArray = name.components(separatedBy: .whitespaces)
        if nameArray.contains("") || nameArray.count < 2 {
            return false
        }
        return true
    }
    
    func showError(label: UILabel, textField: UITextField) {
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
        label.isHidden = false
        textField.text = ""
        
    }
    func resetField(label: UILabel, textField: UITextField) {
        label.isHidden = true
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.15
    }
    
}
