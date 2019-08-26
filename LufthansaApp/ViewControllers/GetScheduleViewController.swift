//
//  GetScheduleViewController.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 06/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import UIKit

class GetScheduleViewController: UIViewController {
  
  @IBOutlet weak var originPoint: UITextField!
  @IBOutlet weak var finalDestination: UITextField!
  @IBOutlet weak var getScheduleButton: UIButton!
  
  override func viewDidLoad() {
     super.viewDidLoad()
      getScheduleButton.addTarget(self, action: #selector(getFlightSchedule), for: .touchUpInside)
    }
  
  @objc fileprivate func getFlightSchedule() {
    //get token first
    WebServices.loginUser { (json) in
    
    }
  }

  }



