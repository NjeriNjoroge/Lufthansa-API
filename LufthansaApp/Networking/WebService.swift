//
//  WebService.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 30/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

let client_id = "e4tvdjjaw2aaarg76y6c6dkn"
let client_secret = "JsaGVUkfJe"
let grant_type = "client_credentials"

class WebService {
  
  //get token
  static func getToken(completion: @escaping (String) -> ()) {
    
    let requestName = "GetToken"
    var accessTokn = ""
    
    let body = ["client_id": client_id,
                "client_secret": client_secret,
                "grant_type": grant_type]
    
    let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
    
    AF.request("https://api.lufthansa.com/v1/oauth/token", method: .post, parameters: body, encoding: URLEncoding(), headers: headers).validate()
      .responseJSON { response in
      
        switch response.result {
          
        case .success(let json):
          if let response = json as? NSDictionary {
            let accessToken = response.object(forKey: "access_token") as? String
            guard let unwrappedAccessToken = accessToken else { return }
            accessTokn = unwrappedAccessToken
          }

            completion(accessTokn)
            UserDataService.shared.token = accessTokn
     
        case .failure(let error):
          var message = ""
          if let httpStatusCode = response.response?.statusCode {
            switch httpStatusCode {
              case 401:
                message = "Invalid token"
                default:
              message = error.localizedDescription
            }
          }
          //let alert = AlertPresenter(title: "Error", message: message)
          //alert.present(in: self)
          print("\(requestName) \(error.localizedDescription)")
        }
    }
  }

  //get flight schedule
  static func getFlightSchedule(originAirport: String, destinationAirport: String, fromDate: String) -> [FlightSchedule] {
    
    let requestName = "GetFlightSchedule"
    var unwrappedAccessToken = ""
    if let accessToken = UserDataService.shared.token {
      unwrappedAccessToken = accessToken
    }
    
    let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(unwrappedAccessToken)"]
    
    AF.request("https://api.lufthansa.com/v1/operations/schedules/\(originAirport)/\(destinationAirport)/\(fromDate)?directFlights=true", method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in

         switch response.result {
           
         case .success(let json):
           if let response = json as? NSDictionary {
            let flightData = response.object(forKey: "Schedule") as? [String: Any]
           }
          
          print(response)

      
         case .failure(let error):
          var message = ""
          if let httpStatusCode = response.response?.statusCode {
            switch httpStatusCode {
              case 401:
                message = "Invalid token"
            case 404:
                message = "No flight matched the criteria"
            default:
                message = error.localizedDescription
            }
          }
          let alert = Alert.simpleAlert(message: message, title: "Error")
          print("\(requestName) \(error.localizedDescription)")
         }

    }
    
    return []
  }
  
}
