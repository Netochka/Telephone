//
//  AddVC.swift
//  Telephone Book
//
//  Created by User on 17.08.2018.
//  Copyright © 2018 e-legion. All rights reserved.
//

import UIKit

var identifierDone = "doDone"

class AddVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var secondNameLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var fioLabel: UILabel!
    
    var contact: Contact?
    var isEdit: Bool = true
    
    var delegate: CreatebleAndEditable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var fio = ""
        if let name = contact?.name {
            firstNameLabel.text = name
            fio += String(name.first!)
        }
        if let surname = contact?.surname, surname != "" {
            secondNameLabel.text = surname
            fio += String(surname.first!)
        }
        if let phone = contact?.phone {
            phoneLabel.text = phone
        }
        if imageViewUser.image == nil {
            fioLabel.text = fio.uppercased()
            imageViewUser.layer.borderColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1) //UIColor.gray.cgColor
        }
        if let img = contact?.image {
            fioLabel.text = ""
            imageViewUser.image = img
            imageViewUser.layer.borderColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        }

        imageViewUser.layer.borderWidth = 5.0
        imageViewUser.layer.masksToBounds = false
        imageViewUser.layer.cornerRadius = imageViewUser.frame.size.height / 2
        imageViewUser.clipsToBounds = true
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
                    delegate?.edit(contact: c, newName: name, newSurname: secondNameLabel.text, newPhone: phone, newImage: imageViewUser.image)
                }
            } else {
                delegate?.add(contact: Contact(name: name, surname: secondNameLabel.text, phone: phone, image: imageViewUser.image))
            }
            //dismiss(animated: true)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    /*
    // prepeare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifierDone {
            let name = firstNameLabel.text!
            let surname = secondNameLabel.text
            let phone = phoneLabel.text!
            
            if isEdit{
                if let c = contact {
                    if let img = imageViewUser {
                        delegate?.edit(contact: c, newName: name, newSurname: surname, newPhone: phone, newImage: img.image)
                    } else {
                        delegate?.edit(contact: c, newName: name, newSurname: surname, newPhone: phone, newImage: nil)
                    }
                }
            } else {
                if let img = imageViewUser {
                    delegate?.add(contact: Contact(name: name, surname: surname, phone: phone, image: img.image))
                } else {
                    delegate?.add(contact: Contact(name: name, surname: surname, phone: phone, image: nil))
                }
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == identifierDone {
            if let name = firstNameLabel.text, let phone = phoneLabel.text {
                guard phone != "" && name != "" else {
                    wrongLabel.text = "You must enter name and phone"
                    return false
                }
            }
        }
        return true
    }
 */

    @IBAction func changePhoto(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageViewUser.image = selectedPhoto
        fioLabel.text = ""
        imageViewUser.layer.borderColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        dismiss(animated: true, completion: nil)
    }
    
}
