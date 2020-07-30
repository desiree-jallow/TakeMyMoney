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
    @IBOutlet var creditButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var paymentMethodLabel: UILabel!
   
    @IBOutlet var datePicker: UIDatePicker!
    
//    let creditCell = CreditTableViewCell()
//    let paypalCell = PaypalTableViewCell()
    
    let creditIndexPath = IndexPath(row: 1, section: 0)
    let paypalIndexPath = IndexPath(row: 2, section: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditButton.isSelected = true
       
        paypalButton.layer.cornerRadius = 8
        creditButton.layer.cornerRadius = 8
        confirmButton.layer.cornerRadius = 8
        paypalButton.backgroundColor = .gray
//        creditCell.validTextFied.inputView = datePicker
        
        
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
//        creditCell.validTextFied.text = dateFormatter.string(from: datePicker.date)
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
//        switch indexPath {
//        case paypalIndexPath:
//            if paypalButton.isSelected {
//                height = 176.0
//
//            } else if creditButton.isSelected {
//                height = 0.0
//            }
//        case creditIndexPath:
//            if creditButton.isSelected {
//                height = 622.0
//
//            } else if paypalButton.isSelected {
//                height = 0.0
//            }
//        default:
//            return UITableView.automaticDimension
//        }
//        return height
        return height
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   

    
}
