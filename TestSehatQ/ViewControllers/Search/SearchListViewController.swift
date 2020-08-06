//
//  SearchListViewController.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import Contacts

protocol SearchListInteractor {
    func cellContactDidTapped(_ contact: CNContact)
}

extension SearchListInteractor {
    func cellContactDidTapped(_ contact: CNContact){}
}

class SearchListViewController: UIViewController {
    
    @IBOutlet weak var searchViewContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchViewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var viewModel: SearchViewModel!
    var contacts = [CNContact]()
    let store = CNContactStore()
    var interactor: SearchListInteractor?
    
    
    init(_ viewModel: SearchViewModel) {
        super.init(nibName: "SearchListViewController", bundle: nil)
        self.viewModel = viewModel
        self.viewModel.interactor = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponents()
    }
}

//MARK: - Set Components
extension SearchListViewController {
    private func setComponents() {
        navigationItem.title = "Search"
        searchTextField.delegate = self
        searchTextField.setLeftPaddingPoints(10)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactSearchCell.self)
        tableView.removeEmptyCell = true
    }
}

//MARK: - TableView Delegate and DataSource
extension SearchListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let type = viewModel.type else { return 0 }
        switch type {
        case .contact:
            return viewModel.contents.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let type = viewModel.type else { return UITableViewCell() }
        switch type {
        case .contact:
            let cell: ContactSearchCell = tableView.dequeueReusableCell(for: indexPath)
            let dataContact = viewModel.contents[indexPath.row]
            if dataContact.phoneNumbers.first?.value.stringValue != nil {
                cell.configureCell(contact: viewModel.contents[indexPath.row])
            }
            return cell
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
        guard let type = viewModel.type else { return }
        switch type {
        case .contact:
            guard let contact = viewModel.contents[indexPath.row] as? CNContact else { return }
            let dataContact = viewModel.contents[indexPath.row]
            if dataContact.phoneNumbers.first?.value.stringValue != nil {
                interactor?.cellContactDidTapped(contact)
            }
        default:
            break
        }
    }
}

//MARK: - UITextfield Delegate
extension SearchListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let stringValue: NSString = textField.text as NSString? else { return false }
        let combinedText:String = stringValue.replacingCharacters(in: range, with: string)
        guard let type = self.viewModel.type else { return false }
        viewModel.searchAutoCompleteWithString(value: combinedText, type: type)
        return true
    }
}

//MARK: - SearchViewModel Interactor
extension SearchListViewController: SearchViewModelInteractor {
    func searchContactAutoComplete(_ contents: [CNContact]) {
        DispatchQueue.main.async {
            self.viewModel.contents = contents
            if self.viewModel.contents.count == 0 {
                self.viewModel.getContacts()
            }
            self.tableView.reloadData()
        }
    }
}
