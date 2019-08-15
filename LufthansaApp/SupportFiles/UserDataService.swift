//
//  UserDataService.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 06/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import Foundation

class UserDataService {
  
  /// the singleton
  static let shared = UserDataService()
  
  // prevent others from using the default initializer of this class
  private init() {}
  
  /// the token
  var token: String!
  
}
