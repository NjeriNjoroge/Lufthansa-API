//
//  GetScheduleViewController.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 06/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import UIKit

class GetScheduleViewController: UIViewController {
  
  let originAirportPicker = UIPickerView()
  let destinationAirportPicker = UIPickerView()
  let toolBar = UIToolbar() //picker toolbar
  
  @IBOutlet weak var originPoint: UITextField!
  @IBOutlet weak var finalDestination: UITextField!
  @IBOutlet weak var getScheduleButton: UIButton!
  
   let originAirports = ["ATL", "PEK", "LAX", "HND", "ORD", "LHR", "HKA", "PVG", "CDG", "AMS", "DEL", "CAN", "FRA", "DFW", "ICN"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    originAirportPicker.delegate = self
    originAirportPicker.dataSource = self
    destinationAirportPicker.delegate = self
    destinationAirportPicker.dataSource = self
    
    getScheduleButton.addTarget(self, action: #selector(getToken), for: .touchUpInside)
  }
  
  override func loadView() {
    super.loadView()
    
    originPoint.inputView = originAirportPicker
    finalDestination.inputView = destinationAirportPicker
    
    originPoint.inputAccessoryView = toolBar
    finalDestination.inputAccessoryView = toolBar
    
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor.lightGray
    toolBar.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneClick))
    doneButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor :UIColor.darkGray], for: UIControl.State.normal)
    
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    
    toolBar.setItems([spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
  }
  
  
  @objc fileprivate func getToken() {
    WebService.getToken { (token) in
      print(token)
      self.getFlightSchedule()
    }
  }
  
  func getFlightSchedule() {
    print("YEAH")
  }
  
  @objc fileprivate func doneClick() {

    originPoint.resignFirstResponder()
    finalDestination.resignFirstResponder()
    

  }
  
}

extension GetScheduleViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  /* switching between all the pickers so they show relevant info for eact text field */
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch pickerView {
    case originAirportPicker:
      return originAirports.count
    case destinationAirportPicker:
      return originAirports.count
    default:
      return 1
    }
  }
  
  //arranges the different options arrays in the pickers
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch pickerView {
    case originAirportPicker:
      return originAirports[row]
    case destinationAirportPicker:
      return originAirports[row]
    default:
      return ""
    }
  }
  
  //sets the selected value in the textfield
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
    
    switch pickerView {
    case originAirportPicker:
      return originPoint.text = originAirports[row]
    case destinationAirportPicker:
      return finalDestination.text = originAirports[row]
    default:
      return
    }
  }
}



