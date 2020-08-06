//
//  String.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

extension String {
    func cleanPhoneNumberFormat() -> String {
        return self.replacingOccurrences(of: "+62", with: "0").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
    }
}
