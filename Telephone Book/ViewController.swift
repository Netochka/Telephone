//
//  ViewController.swift
//  Telephone Book
//
//  Created by User on 16.08.2018.
//  Copyright © 2018 e-legion. All rights reserved.
//

import UIKit


let identifier = "CellTV"
let identifierEditVC = "goEdit"

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    
    var contacts = [Contact]()
    private var currentContacts = [Contact]()
    private var sections = [ContactSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setUpContacts()
        setUpSearchBar()
        
        currentContacts = contacts
        
        sections = ContactSection.group(contacts: currentContacts)
    }
    
    private func setUpContacts() {
        
        contacts.append(Contact(name: "Sanyk", surname: nil, phone: "123"))
        
        contacts.append(Contact(name: "Anya", surname: "Nosach", phone: "123"))
        contacts.append(Contact(name: "Alina", surname: "Grosu", phone: "123"))
        contacts.append(Contact(name: "Olya", surname: "Beb", phone: "123"))
        
        contacts.append(Contact(name: "Pitor", surname: "Blub", phone: "123"))
        contacts.append(Contact(name: "Petya", surname: "Bebchik", phone: "123"))
        contacts.append(Contact(name: "Seriy", surname: "Xey", phone: "123"))
    }
    
    func setUpSearchBar() {
        searchBar.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return String(sections[section].firstLetter).uppercased()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sections[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableViewCell
        
        let name = sections[indexPath.section].contacts[indexPath.row].name
        
        if let surname = sections[indexPath.section].contacts[indexPath.row].surname {
            cell?.name.text = name + " " + surname
        } else {
            cell?.name.text = name
        }

        return cell!
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        let aScalars = "A".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        
        let alphabet = (0..<26).map {
            i in String(UnicodeScalar(aCode + i)!)
        }
       
        return alphabet
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifierEditVC {
            var selectedContact: Contact
            
            let indexPath = self.tableView.indexPath(for: (sender as! UITableViewCell))
            guard let indP = indexPath else { return }
            
            selectedContact = sections[indP.section].contacts[indP.row]
            let editVC = segue.destination as! EditVC
            editVC.name = selectedContact.name
            editVC.phone = selectedContact.phone
            
            if let surname = selectedContact.surname {
                editVC.surname = surname
            }
        }
    }
    
    // SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            sections = ContactSection.group(contacts: contacts)
            tableView.reloadData()
            return
        }
        currentContacts = contacts.filter({contact -> Bool in
            guard var text = searchBar.text else {return false}
            text = text.lowercased()
            let inName = contact.name.lowercased().contains(text)
            if let surname = contact.surname {
                return inName || surname.lowercased().contains(text)
            }
            
            return inName
        })
        
        sections = ContactSection.group(contacts: currentContacts)
        tableView.reloadData()
    }
    
}
