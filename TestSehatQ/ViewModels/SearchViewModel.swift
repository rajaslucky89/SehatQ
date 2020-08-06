//
//  SearchViewModel.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import Foundation
import RealmSwift
import Contacts

enum SearchType {
    case contact, none
}

protocol SearchViewModelInteractor {
    func searchContactAutoComplete(_ contents: [CNContact])
}

extension SearchViewModelInteractor {
    func searchContactAutoComplete(_ contents: [CNContact]){}
}

protocol SearchViewModelBase {
    var type: SearchType! { get set }
    var contacts: [CNContact]! { get set }
    var store : CNContactStore! { get set }
   func searchAutoCompleteWithString(value: String, type: SearchType)
}

final class SearchViewModel: SearchViewModelBase {
    var interactor: SearchViewModelInteractor?
    var store: CNContactStore!
    var type: SearchType!
    var contents = [CNContact]()
    var contacts: [CNContact]!

    init(type: SearchType) {
        self.type = type
    }
    
    func searchAutoCompleteWithString(value: String, type: SearchType) {
        switch type {
        case .contact:
            var contacts = [CNContact]()
            for contact in getContacts() {
                let givenName = String(describing: contact.givenName)
                let middleName = String(describing: contact.middleName)
                let familyName = String(describing: contact.familyName)
                var phoneNumber = ""
                
                if contact.phoneNumbers.count != 0 {
                    phoneNumber = String(describing: contact.phoneNumbers[0].value.stringValue).cleanPhoneNumberFormat()
                }
                
                if !givenName.isEmpty && !phoneNumber.isEmpty {
                    let contactName : String = [givenName, middleName, familyName, phoneNumber].joined()
                    if contactName.lowercased().contains(value.lowercased()) {
                        contacts.append(contact)
                    }
                }
            }
            self.interactor?.searchContactAutoComplete(contacts)
        default:
            break
        }
    }
}

extension SearchViewModel {
    func getContacts() -> [CNContact] {
        let store = CNContactStore()
        switch CNContactStore.authorizationStatus(for: .contacts){
        case .authorized:
            contents = self.fetchContact()
        case .notDetermined:
            store.requestAccess(for: .contacts){ succeeded, err in
                guard err == nil && succeeded else { return }
                self.contents = self.fetchContact()
            }
        default: break
        }
        return self.contents
    }
    
    func fetchContact() -> [CNContact] {
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey, CNContactThumbnailImageDataKey, CNContactImageDataAvailableKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Error", err)
                return
            }
            
            if granted {
                do {
                    try store.enumerateContacts(with: request) {
                        (contact, stop) in
                        guard let phone = contact.phoneNumbers.first else { return }
                        if !phone.value.stringValue.isEmpty {
                            self.contents.append(contact)
                        }
                        
                    }
                }
                catch {
                    print("unable to fetch contacts")
                }
            } else {
                print("Access Denied")
            }
        }
        
        return self.contents
    }
    
}
