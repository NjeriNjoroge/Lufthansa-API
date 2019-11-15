//
//  DisplayScheduleViewController.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 14/11/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import UIKit

class DisplayScheduleViewController: UIViewController {
  
  let myTableView = UITableView()
  let cell = CustomTableViewCell()
  var flight = [FlightSchedule]()
  let myCellId = "cellId"
  
  var flightDetails: FlightSchedule? {
    didSet {
      updateProperties()
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        getFlightSchedule()
    }
  
  func setupTableView() {
      view.addSubview(myTableView)
      myTableView.translatesAutoresizingMaskIntoConstraints = false
      
      myTableView.dataSource = self
      myTableView.delegate = self
      
      myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: myCellId)
      
      NSLayoutConstraint.activate([
          myTableView.topAnchor.constraint(equalTo: view.topAnchor),
          myTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
          myTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
          myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
          ])
  }
  
  func updateProperties() {
    //we get the values here how do i update my cell below
    if let flightDetails = flightDetails {
      if !cell.flightBla.isEmpty {
        cell.storeDetails = flightDetails
      }
    }
  }
  
  func getFlightSchedule() {
    WebService.getFlightSchedule(originAirport: "LAX", destinationAirport: "ATL", fromDate: "2019-11-26") { (json) in
      if json.stringValue != "error" {
        let results = Parse.parseFlightSchedule(json: json)
        if !results.isEmpty {
          self.flightDetails = results[0]
        }
      }
    }
  }
}

extension DisplayScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: myCellId, for: indexPath) as! CustomTableViewCell
        
     // cell.arriveTimeLabel.text = flight[indexPath.row].arrivalTime
  
        return cell
    }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
    
}

