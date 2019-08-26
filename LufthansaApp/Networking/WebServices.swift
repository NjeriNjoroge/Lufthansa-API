//
//  WebServices.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 06/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import CoreData

public class WebServices {
  
  /**
   The signature of the completion handler for API requests
   
   - parameters:
   - json: the json data from the API
   - error: the error that occurred
   - isSessionValid: indicates if the user's session is valid or not
   */
  typealias _completion = (JSON?, Error?, Bool) -> Void
  
  static let loginEndpointClosure = { (target: AuthService) -> Endpoint in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString.removingPercentEncoding!
    
    let defaultEndpoint = Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
    return defaultEndpoint
  }
  
  public static func loginUser(completion: @escaping (JSON?) -> Void) {
    getToken { (token) in
      UserDataService.shared.token = token
    }
  }
  
   fileprivate static func getToken(completionHandler: @escaping (String) -> ()) {
    
    let provider = MoyaProvider<AuthService>(endpointClosure: loginEndpointClosure, manager: DefaultAlamofireManager.sharedManager)
    provider.request(.getToken) { (result) in
      switch result {
      case let .success(moyaResponse):
        do {
          let statuscode = moyaResponse.statusCode
          print("statuscode catalog \(statuscode)")
          let data = try moyaResponse.mapJSON()
          let json = JSON(data)
          
          // get token
          guard let jsonDict = json.dictionaryObject else {return}
          let token = jsonDict["access_token"] as? String
          if let token = token {
             completionHandler(token)
            UserDataService.shared.token = token
          }
          
        } catch {
          
        }
        
      case let .failure(error):
        print("error token \(error)")
        break
      }
    }
  }
  
  
  public static func getFlightSchedule(origin: String, destination: String, fromDate: String, completionHandler: @escaping (JSON?) -> Void) {
    let requestName = "GetFlightSchedule"
    let provider = MoyaProvider<AuthService>(endpointClosure: loginEndpointClosure, manager: DefaultAlamofireManager.sharedManager)
    provider.request(.getFlightScedule(origin: origin, destination: destination, fromDate: fromDate)) { (result) in
      switch result {
      case let .success(moyaResponse):
        print(result)
      case let .failure(error):
        print("\(requestName) \(error)")
      }
    }
  }
 
  
  
}
