//
//  Parse.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 14/11/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Parse {
  
  var flight = [FlightSchedule]()
  
  static func parseFlightSchedule(json: JSON) -> [FlightSchedule] {
    
    var results = [FlightSchedule]()
    
    let scheduleResource = json["ScheduleResource"]["Schedule"].arrayValue
    scheduleResource.forEach {
      let data = $0["Flight"]
      let departure = data["Departure"]["ScheduledTimeLocal"]["DateTime"].string ?? ""
      let arrival = data["Arrival"]["ScheduledTimeLocal"]["DateTime"].string ?? ""
      print("flightArrival \(arrival)")
      print("flightDeparture \(departure)")
      let flightScheduleObject = FlightSchedule(departureDay: departure, arrivalTime: arrival)
      results.append(flightScheduleObject)
    }
    
    return results
  }
  
}
