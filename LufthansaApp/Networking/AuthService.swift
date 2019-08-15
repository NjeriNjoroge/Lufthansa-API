//
//  AuthService.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 06/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import Foundation
import Moya

let client_id = "e4tvdjjaw2aaarg76y6c6dkn"
let client_secret = "JsaGVUkfJe"
let grant_type = "client_credentials"

enum AuthService {
  case getToken
}

extension AuthService: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.lufthansa.com/v1/")!
  }
  
  var path: String {
    switch self {
    case .getToken:
      return "oauth/token"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getToken:
      return .post
    default:
      return .get
    }
  }
  
  var sampleData: Data {
    return self.sampleData
  }
  
  
  
  // payload / http parameters
  var parameters: [String: Any]? {
      return nil
  }
  
  var headers: [String: String]? {
    switch self {
    case .getToken:
      return ["Content-Type": "application/x-www-form-urlencoded"]
    }
  }
  
  
  
  var task: Task {
    switch self {
    case .getToken:
      let params = ["client_id": "\(client_id)", "client_secret": "\(client_secret)", "grant_type": "\(grant_type)"]
      return .requestParameters(parameters: params, encoding: URLEncoding.default)
    default:
      return .requestPlain
    }
    
  }

  
}
