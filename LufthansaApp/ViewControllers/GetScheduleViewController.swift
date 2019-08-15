//
//  GetScheduleViewController.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 06/08/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import UIKit

class GetScheduleViewController: UIViewController {
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Enter airport origin and destination to get\nflight schedule"
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  
  var originLabel: UILabel = {
    let label = UILabel()
    label.text = "Origin:"
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var destinationLabel: UILabel = {
    let label = UILabel()
    label.text = "Destination:"
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var originTF: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Origin airport"
    tf.isEnabled = true
    tf.textColor = .red
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  var destinationTF: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Destination airport"
    tf.isEnabled = true
    tf.textColor = .red
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  var searchButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Get schedule", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .black
    button.addTarget(self, action: #selector(getToken), for: .touchUpInside)
    return button
  }()

    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = .white
      setupUI()
    }
  
  fileprivate func setupUI() {
    view.addSubview(titleLabel)
    view.addSubview(originLabel)
    view.addSubview(destinationLabel)
    view.addSubview(originTF)
    view.addSubview(destinationTF)
    view.addSubview(searchButton)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
      titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      originLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
      originLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
      destinationLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 30),
      destinationLabel.leftAnchor.constraint(equalTo: originLabel.leftAnchor)
      ])
    
    NSLayoutConstraint.activate([
      originTF.topAnchor.constraint(equalTo: originLabel.topAnchor),
      originTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      destinationTF.topAnchor.constraint(equalTo: destinationLabel.topAnchor),
      destinationTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
      ])
    
    NSLayoutConstraint.activate([
      searchButton.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor, constant: 30),
      searchButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      searchButton.heightAnchor.constraint(equalToConstant: 47)
      ])
  }

  @objc fileprivate func getToken() {
    //do network call
//    WebServices.getFlightSchedule(origin: "FRA", dest: "HKG") { (json, error, isValidSession) in
//      print(json)
//    }
    WebServices.getToken { (json) in
      print("Token: \(json)")
    }
      print(UserDataService.shared.token)
    }

}
