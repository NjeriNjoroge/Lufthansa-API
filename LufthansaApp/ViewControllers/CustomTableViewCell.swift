//
//  CustomTableViewCell.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 14/11/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
  var arriveTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "Arrive"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var departureTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "Departure"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpViews()
  }
    
  func setUpViews() {
    addSubview(arriveTimeLabel)
    addSubview(departureTimeLabel)
    
    NSLayoutConstraint.activate([
      arriveTimeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      arriveTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
      departureTimeLabel.topAnchor.constraint(equalTo: arriveTimeLabel.bottomAnchor, constant: 8),
      departureTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
      ])
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

}
