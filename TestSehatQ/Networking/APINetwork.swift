//
//  APINetwork.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import Foundation
import Moya

enum APINetwork {
    case getProduct
}

extension APINetwork: TargetType {
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8) ?? Data()
    }
    
    //  MARK: - Set Network Base Url
    public var baseURL: URL {
        return URL(string: NetworkUrl.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .getProduct:
            return "home"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getProduct:
            return .get
        }
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var parameters: [String:Any] {
        return [String:Any]()
    }
    
    public var urlParameters: [String:Any] {
        return [String:Any]()
    }
    
    public var headers: [String: String]? {
        return [String:String]()
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    //  MARK: - Set Network Parameter Encoding
    var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
}

