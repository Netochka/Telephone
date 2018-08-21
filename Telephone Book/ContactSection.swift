//
//  ContactSection.swift
//  Telephone Book
//
//  Created by User on 21.08.2018.
//  Copyright © 2018 e-legion. All rights reserved.
//

import UIKit

class ContactSection: NSObject, Comparable {
    
    var firstLetter: Character
    var contacts: [Contact]
    
    init(firstLetter: Character, contacts: [Contact]) {
        self.firstLetter = firstLetter
        self.contacts = contacts
    }
    
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
