//
//  EditVC.swift
//  Telephone Book
//
//  Created by User on 21.08.2018.
//  Copyright © 2018 e-legion. All rights reserved.
//

import UIKit

var identifierDone = "doDoneEdit"

class EditVC: UIViewController {

    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var secondNameLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var wrongLabel: UILabel!
    
    var name, surname, phone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let n = name {
            firstNameLabel.text = n
        }
        if let s = surname {
            secondNameLabel.text = s
        }
        if let p = phone {
            phoneLabel.text = p
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifierDone
        {
            let mainVC = segue.destination as! ViewController
            if let name = firstNameLabel.text, let phone = phoneLabel.text {
                mainVC.contacts.remove(at: <#T##Int#>)
                mainVC.contacts.append(Contact(name: name, surname: secondNameLabel.text, phone: phone))
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == identifierDone, let name = firstNameLabel.text, let phone = phoneLabel.text {
            if phone.isEmpty || name.isEmpty {
                wrongLabel.text = "You must enter name and phone"
                return false
            }
        }
        
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
