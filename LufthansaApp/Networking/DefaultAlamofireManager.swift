//
//  DefaultAlamofireManager.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 06/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import Alamofire

import Alamofire

public class DefaultAlamofireManager: Alamofire.SessionManager {
  static let sharedManager: DefaultAlamofireManager = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 30 // as seconds, you can set your request timeout
    configuration.timeoutIntervalForResource = 30 // as seconds, you can set your resource timeout
    configuration.requestCachePolicy = .useProtocolCachePolicy
    
    // WE NEED TO REMOVE THIS BEFORE LIVE!!
    let serverTrustPolicyManager = CustomServerTrustPoliceManager()
    return DefaultAlamofireManager(configuration: configuration, serverTrustPolicyManager: serverTrustPolicyManager)
  }()
}
class CustomServerTrustPoliceManager: ServerTrustPolicyManager {
  override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
    return .disableEvaluation
  }
  public init() {
    super.init(policies: [:])
  }
}
