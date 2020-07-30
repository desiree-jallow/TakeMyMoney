//
//  PaymentDataTableViewController.swift
//  TakeMyMoney
//
//  Created by Desiree on 7/23/20.
//  Copyright © 2020 Desiree. All rights reserved.
//

import UIKit

class PaymentDataTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet var paypalButton: UIButton!
    @IBOutlet var creditButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var paymentMethodLabel: UILabel!
    @IBOutlet var validTextField: UITextField!
   
    
    let creditIndexPath = IndexPath(row: 1, section: 0)
    let paypalIndexPath = IndexPath(row: 2, section: 0)
    
    
    
    
    
    
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
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
    
}
