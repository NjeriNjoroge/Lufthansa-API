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
  
  fileprivate static func getToken(completionHandler: @escaping (JSON?, Error?) -> Void) {
    
    let provider = MoyaProvider<AuthService>(endpointClosure: loginEndpointClosure, manager: DefaultAlamofireManager.sharedManager)
    provider.request(.getToken) { (result) in
      switch result {
      case let .success(moyaResponse):
        do {
          let data = try moyaResponse.mapJSON()
          let json = JSON(data)
          // get token
          guard let jsonDict = json.dictionary, let token = jsonDict["access_token"]?.stringValue else {return}
          UserDataService.shared.token = token
        } catch {
          let json = JSON("")
          completionHandler(json, error)
        }
        
      case let .failure(error):
        let json = JSON(error)
        completionHandler(json, error)
        print(json)
      }
    }
  }
  
//  static func getFlightSchedule(origin: String, dest: String, completion: @escaping _completion) {
//    let provider = MoyaProvider<AuthService>(endpointClosure: defaultEndpoint, manager: DefaultAlamofireManager.sharedManager)
//    provider.request(.getFlight(origin: origin, destination: dest)) { (result) in
//      switch result {
//      case let .success(moyaResponse):
//        do {
//          let data = try moyaResponse.mapJSON()
//          let json = JSON(data)
//          
//          debugPrint("getFlightSchedule: \(json)")
//          
//        } catch {
//          let json = JSON("")
//          //completionHandler(json)
//        }
//        
//      case let .failure(error):
//        let json = JSON(error)
//        //completionHandler(json)
//        print(json)
//      }
//    }
//  }
  
  
}
