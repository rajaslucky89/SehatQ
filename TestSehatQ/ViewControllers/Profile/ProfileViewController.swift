//
//  ProfileViewController.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HistoryViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponents()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getDataHistory()
    }
}

extension ProfileViewController {
    private func setComponents() {
        title = Attribute.profile
        
        //  Configure TableView
        tableView.register(HistoryCell.self)
        tableView.removeEmptyCell = true
        
        // Set Refresh Control
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    private func getDataHistory() {
        viewModel.getData()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        if viewModel.items.count != 0 {
            getDataHistory()
        } else {
            refreshControl.endRefreshing()
        }
        
    }
}

//  MARK: - UITableView Delegate & Data Source
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureCell(viewModel.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index ke \(indexPath.row)")
    }
}
