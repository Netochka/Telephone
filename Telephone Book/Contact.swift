//
//  Contact.swift
//  Telephone Book
//
//  Created by User on 21.08.2018.
//  Copyright © 2018 e-legion. All rights reserved.
//

import UIKit

class Contact: NSObject, Comparable {
    
    var name: String
    var surname: String?
    var phone: String
    
    init(name: String, surname: String?, phone: String) {
        self.name = name
        self.surname = surname
        self.phone = phone
    }
    
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
