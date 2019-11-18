//
//  DisplayScheduleViewController.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 14/11/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import UIKit

class DisplayScheduleViewController: UIViewController {
  
  @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
  
  let myTableView = UITableView()
  let cell = CustomTableViewCell()
  var flight = [FlightSchedule]()
  var resultFlight = [FlightSchedule]()
  let myCellId = "cellId"
  
  var flightDetails: FlightSchedule? {
    didSet {
      updateProperties()
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

      setupTableView()
      getFlightSchedule { (json) in
        debugPrint("results")
      }
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
    //we get the values here
    myTableView.reloadData()
  }
  
  func getFlightSchedule(completionHandler: @escaping ([FlightSchedule]) -> Void) {
    createSpinnerView()
    WebService.getFlightSchedule(originAirport: "LAX", destinationAirport: "ATL", fromDate: "2019-11-26") { (json) in
      if json.stringValue != "error" {
        let results = Parse.parseFlightSchedule(json: json)
        if !results.isEmpty {
          self.flightDetails = results[0]
        }
        for all in results {
          self.flight.append(all)
        }
        self.resultFlight += self.flight
        self.myTableView.reloadData()
        completionHandler(results)
      }
    }
  }
  
  func createSpinnerView() {
    let spinner = SpinnerViewController()
    let child = SpinnerViewController()

      // add the spinner view controller
      addChild(child)
      child.view.frame = view.frame
      view.addSubview(child.view)
      child.didMove(toParent: self)
    
    // wait two seconds to simulate some work happening
       DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
           // then remove the spinner view controller
           child.willMove(toParent: nil)
           child.view.removeFromSuperview()
           child.removeFromParent()
       }
  }
}

extension DisplayScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return resultFlight.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: myCellId, for: indexPath) as! CustomTableViewCell
      
      if resultFlight.count > 0 {
        cell.arriveTimeLabel.text = "Arrive: \(resultFlight[indexPath.row].arrivalTime)"
        cell.departureTimeLabel.text = "Departure: \(resultFlight[indexPath.row].departureDay)"
      }
        
        return cell
    }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
    
}

