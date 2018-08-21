//
//  AddVC.swift
//  Telephone Book
//
//  Created by User on 17.08.2018.
//  Copyright © 2018 e-legion. All rights reserved.
//

import UIKit

class AddVC: UIViewController {

    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var secondNameLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var wrongLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doDone"
        {
            print("doDone")
            let mainVC = segue.destination as! ViewController
            if let name = firstNameLabel.text, let phone = phoneLabel.text {
                mainVC.contacts.append(Contact(name: name, surname: secondNameLabel.text, phone: phone))
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "doDone", let name = firstNameLabel.text, let phone = phoneLabel.text {
            if phone.isEmpty || name.isEmpty {
                wrongLabel.text = "You must enter name and phone"
                return false
            }
        }

        print("okey")
        return true
    }
    
}
