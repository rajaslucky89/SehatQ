//
//  DashboardViewModel.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

protocol HomeInput {
    var categories: [Category] { get set }
    var product: [Product] { get set }
    var networkService: GeneralNetworkService { get set }
}

protocol HomeViewModelInteractor {
    func successGetData()
    func failedGetData(error: Error)
}

final class HomeViewModel: HomeInput {
    var categories: [Category]
    var product: [Product]
    var networkService: GeneralNetworkService
    var interactor: HomeViewModelInteractor?
    
    
    init() {
        self.networkService = GeneralNetworkService()
        self.categories = [Category]()
        self.product = [Product]()
        self.networkService.interactor = self
        networkService.request(.getProduct)
    }
}

//  MARK: - General Network Service Interactor
extension HomeViewModel: GeneralNetworkServiceInteractor {
    func success(_ object: NetworkData, type: APINetwork) {
        guard let data = object.data else { return }
        self.categories = data.category ?? [Category]()
        self.product = data.promos ?? [Product]()
        interactor?.successGetData()
    }
    
    func failed(_ error: Error, type: APINetwork) {
        interactor?.failedGetData(error: error)
    }
}
