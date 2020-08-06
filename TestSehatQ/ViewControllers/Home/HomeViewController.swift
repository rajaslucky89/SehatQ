//
//  HomeViewController.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

protocol HomeControllerInteractor {
    func getContents(_ contents: [Any])
}

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HomeViewModel()
    var interactor: HomeControllerInteractor?

    override func viewDidLoad() {
        super.viewDidLoad()
        setComponents()
        setRightNavigation()
    }
}

extension HomeViewController {
    private func setComponents() {
        title = Attribute.home
        navigationController?.setDefault()
        showLoader(.gray)
        
        // Set interactor
        viewModel.interactor = self
        
        //  Configure CollectionView
        collectionView.register(CategoryCell.self)
        collectionView.setCornerRadius(10.0)
        
        //  Configure TableView
        tableView.register(ProductCell.self)
        tableView.removeEmptyCell = true
    }
    
    private func setRightNavigation() {
        let rightBarButton = UIBarButtonItem(image: ImageName.iconSearch, style: .plain, target: self, action: #selector(showSearchPage))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func showSearchPage() {
        let viewModel = SearchViewModel(type: .contact)
        redirectTo(SearchListViewController(viewModel))
    }
}

//  MARK: - CollectionView Delegate & Data Source
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.configureCell(viewModel.categories[indexPath.row])
        return cell
    }
    
    //  Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width / 4) * 0.8
        let height = view.frame.size.width / 4
        return CGSize(width: width, height: height)
    }
}

//  MARK: - UITableView Delegate & Data Source
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.product.count
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
        let cell: ProductCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureCell(viewModel.product[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = DetailProductViewModel(self.viewModel.product[indexPath.row])
        redirectTo(DetailProductController(viewModel))
    }
}

extension HomeViewController: HomeViewModelInteractor {
    func successGetData() {
        collectionView.reloadData()
        tableView.reloadData()
        interactor?.getContents(viewModel.product)
        hideLoader()
    }
    
    func failedGetData(error: Error) {
        
    }
}
