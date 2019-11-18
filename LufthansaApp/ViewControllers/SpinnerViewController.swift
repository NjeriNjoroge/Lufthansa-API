//
//  SpinnerViewController.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 18/11/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
  
   var spinner = UIActivityIndicatorView(style: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
