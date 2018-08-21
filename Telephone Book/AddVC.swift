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
    
    //var name, surname, phone: String?
    var contact: Contact?
    var isEdit: Bool = true
    
    var delegate: CreatebleAndEditable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = contact?.name {
            firstNameLabel.text = name
        }
        if let surname = contact?.surname {
            secondNameLabel.text = surname
        }
        if let phone = contact?.phone {
            phoneLabel.text = phone
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel() {
        dismiss(animated: true)
    }
    
    @IBAction func done() {
        if let name = firstNameLabel.text, let phone = phoneLabel.text {
            guard phone != "" && name != "" else {
                wrongLabel.text = "You must enter name and phone"
                return
            }
            if isEdit{
                if let c = contact {
                    print("\n\n\ni'm here\n\n\n\n")
                    delegate?.edit(contact: c, newName: name, newSurname: secondNameLabel.text, newPhone: phone)
                }
            } else {
                delegate?.add(contact: Contact(name: name, surname: secondNameLabel.text, phone: phone))
            }
            dismiss(animated: true)
        }
    }
    
/*
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

        return true
    }
 
 */
}
