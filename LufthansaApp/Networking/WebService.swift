//
//  WebService.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 30/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import Foundation
import Alamofire

class WebService {
  
  //get token
  static func getToken(completion: @escaping (String) -> ()) {
    let requestName = "GetToken"
    
    AF.request(Endpoint.getToken).validate().responseJSON { (response) in
      switch response.result {
        
      case .success(let json):
        print(response)
        if let response = json as? NSDictionary {
          let accessToken = response.object(forKey: "access_token") as? String
          if let token = accessToken {
            completion(token)
            UserDataService.shared.token = token
          }
        }
        
      case .failure(let error):
        print("\(requestName) \(error.localizedDescription)")
      }
    }
  }
  
  //get flight schedule
  static func getFlightSchedule()  {}
  
  

  

}
