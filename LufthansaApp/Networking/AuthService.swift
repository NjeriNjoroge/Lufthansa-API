//
//  AuthService.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 30/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import Foundation
import Alamofire

let client_id = "e4tvdjjaw2aaarg76y6c6dkn"
let client_secret = "JsaGVUkfJe"
let grant_type = "client_credentials"

enum Endpoint: URLRequestConvertible {
  
  case getToken
  case getFlightScedule(origin: String, destination: String, fromDate: String)
  
  var path: String {
    switch self {
    case .getToken:
      return "oauth/token"
    case .getFlightScedule(let origin, let destination, let fromDate):
      return "/operations/schedules/\(origin)/\(destination)/\(fromDate)"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getToken:
      return .post
    default:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .getToken:
      return ["Content-Type": "application/x-www-form-urlencoded"]
    case .getFlightScedule:
      return ["Accept": "application/json", "Authorization": "bearer \(UserDataService.shared.token)"]
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    case .getToken:
      return JSONEncoding.default
    default:
      return URLEncoding()
    }

  }
  
  var parameters: Parameters? {
    switch self {
    case .getToken:
      return ["client_id": client_id, "client_secret": client_secret, "grant_type": grant_type]
    default:
      return nil
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try BaseURL.APIServer.baseURL.asURL()
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    //HTTP method
    urlRequest.httpMethod = method.rawValue
    
    //HTTP Headers
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    urlRequest.setValue(ContentType.application.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
    
    if let parameters = parameters {
      do {
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
      } catch {
        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
      }
    }
    print(urlRequest)
    return urlRequest
  }
  
}
