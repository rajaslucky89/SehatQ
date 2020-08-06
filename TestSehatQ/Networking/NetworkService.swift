//
//  NetworkService.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import ObjectMapper
import Alamofire
import CFNetwork

class NetworkService {
    var provider: MoyaProvider<APINetwork>!
    var target: APINetwork!
    
    init(_ target: APINetwork) {
        self.target = target
    }
    
    static func getSessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForResource = 180
        configuration.timeoutIntervalForRequest = 180
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        
        let sessionManager = SessionManager.init(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: ServerTrustPolicyManager(policies: [:]))
        return sessionManager
    }
    
    public func request(success successCallback: @escaping (NetworkData) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        let sessionManager = NetworkService.getSessionManager()
        
        provider = MoyaProvider<APINetwork>(manager: sessionManager, plugins: [NetworkLoggerPlugin(verbose: false)])
        provider.request(self.target) { (result) in
            switch result {
            case .success(let response):
                var data = NetworkData()
                do {
                    let json = try response.mapJSON() as? [[String : Any]] ?? [[String:Any]]()
                    data = NetworkData(JSON: json.first!) ?? NetworkData()
                } catch {
                    data = NetworkData()
                }
                
                successCallback(data)
            case .failure(let error):
                guard let response = error.response else { errorCallback(error); return }
                var data = [String:Any]()
                
                do {
                    data = try response.mapJSON() as! [String:Any]
                } catch {
                    data = [String:Any]()
                }
                
                let code: Int = data["code"] as? Int ?? 99
                let message: String = data["message"] as? String ?? Attribute.errorMaintenance
                let convertedError = NSError(domain: NetworkUrl.baseUrl, code: code, userInfo:[NSLocalizedDescriptionKey: message])
                errorCallback(convertedError)
            }
        }
    }
}


protocol GeneralNetworkServiceInteractor {
    func success(_ object: NetworkData, type: APINetwork)
    func failed(_ error: Error, type: APINetwork)
}

//  Networking
struct GeneralNetworkService {
    var interactor: GeneralNetworkServiceInteractor?
    
    public func request(_ target: APINetwork) {
        let networkService = NetworkService(target)
        networkService.request(success: { (object) in
            self.interactor?.success(object, type: target)
        }, error: { (error) in
            self.interactor?.failed(error, type: target)
        }) { (error) in
            self.interactor?.failed(error, type: target)
        }
    }
}
