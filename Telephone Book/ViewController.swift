//
//  ViewController.swift
//  Telephone Book
//
//  Created by User on 16.08.2018.
//  Copyright © 2018 e-legion. All rights reserved.
//

import UIKit


let identifier = "CellTV"

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    
    var contacts = [Contact]()
    private var currentContacts = [Contact]()
    private var sections = [ContactSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

struct Contact: Comparable {
    
    let name: String
    let surname: String?
    let phone: String
    
    // Comparable functions
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        var fullNameL = lhs.name.lowercased()
        var fullNameR = rhs.name.lowercased()
        
        if let surname = lhs.surname {
            fullNameL += surname.lowercased()
        }
        
        if let surname = rhs.surname {
            fullNameR += surname.lowercased()
        }
        
        return fullNameL < fullNameR
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        var fullNameL = lhs.name
        var fullNameR = rhs.name
        
        if let surname = lhs.surname {
            fullNameL += surname
        }
        
        if let surname = rhs.surname {
            fullNameR += surname
        }
        
        return fullNameL == fullNameR
    }
}

struct ContactSection: Comparable {
    
    var firstLetter: Character
    var contacts: [Contact]
    
    static func group(contacts : [Contact]) -> [ContactSection] {
        // grouping by contact.name[0]
        let groups = Dictionary(grouping: contacts) { (contact) in
        return contact.name.lowercased()[contact.name.index(contact.name.startIndex, offsetBy: 0)]
    }
        // for each [firstLetter: [contact]] && sorted
        var sections = groups.map {(k, v) in
            return ContactSection(firstLetter: k, contacts: v)
        }.sorted()
        
        // sort in each section
        for i in 0..<sections.count {
            sections[i].contacts.sort()
        }
        
        return sections
    }
    
    // Comparable functions
    static func < (lhs: ContactSection, rhs: ContactSection) -> Bool {
        let fullNameL = lhs.firstLetter
        let fullNameR = rhs.firstLetter
        
        return fullNameL < fullNameR
    }
    
    static func == (lhs: ContactSection, rhs: ContactSection) -> Bool {
        let fullNameL = lhs.firstLetter
        let fullNameR = rhs.firstLetter
        
        return fullNameL == fullNameR
    }
}

