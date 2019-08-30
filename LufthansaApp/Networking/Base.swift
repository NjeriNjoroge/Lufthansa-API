//
//  Base.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 30/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import Foundation

struct BaseURL {
  //You can add different url for production, test, acceptance
  struct APIServer {
    static let baseURL = "https://api.lufthansa.com/v1/"
  }
}

enum HTTPHeaderField: String {
  case authentication = "Authorization"
  case contentType = "Content-Type"
  case acceptType = "Accept"
  case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
  case json = "application/json"
  case application = "application/x-www-form-urlencoded"
}
