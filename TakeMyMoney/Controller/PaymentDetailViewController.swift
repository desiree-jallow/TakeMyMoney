//
//  PaymentDetailViewController.swift
//  TakeMyMoney
//
//  Created by Desiree on 8/6/20.
//  Copyright © 2020 Desiree. All rights reserved.
//

import UIKit

class PaymentDetailViewController: UIViewController {
    
    @IBOutlet var paymentImage: UIImageView!
    @IBOutlet var paymentLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var payButton: UIButton!
    
    var image: String?
    var paymentDetail: String?
    var titleInfo: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        payButton.layer.cornerRadius = 8
        
        if let image = image {
        paymentImage.image = UIImage(named: image)
        }
        
        paymentLabel.text = paymentDetail
        titleLabel.text = titleInfo
    

        // Do any additional setup after loading the view.
    }
    //create alert pop up for pay button
    @IBAction func payButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Uh Oh!", message: "Your payment has failed!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
