//
//  ContactSearchCell.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import Contacts

class ContactSearchCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicture.roundCorners(corners: .allCorners, radius: 50)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


//  MARK:   - Set Components
extension ContactSearchCell {
    func configureCell(contact: CNContact) {
        self.name.text = [contact.givenName, contact.familyName].joined(separator: " ")
        self.phoneNumber.text = String(describing: contact.phoneNumbers[0].value.stringValue).cleanPhoneNumberFormat()
    }
    
}

extension ContactSearchCell: ReusableCell {}

