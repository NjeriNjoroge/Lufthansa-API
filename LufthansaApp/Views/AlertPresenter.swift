//
//  AlertPresenter.swift
//  LufthansaApp
//
//  Created by Grace Njoroge on 05/11/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import UIKit

//struct AlertPresenter {
//    let title: String
//    let message : String
//}
//
///// primary used to display API Errors so the presentation is pushed to main thread by default
//extension AlertPresenter {
//    func present(in viewcontroller: UIViewController) {
//        let actionsheet = UIAlertController(title: title,
//                                            message: message,
//                                            preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
//            actionsheet.dismiss(animated: true, completion: nil)
//        }
//        actionsheet.addAction(action)
//        DispatchQueue.main.async {
//            viewcontroller.present(actionsheet, animated: true, completion: nil)
//        }
//    }
//
//
//    func present(in viewcontroller: UIViewController, actions: [UIAlertAction]) {
//        let actionsheet = UIAlertController(title: title,
//                                            message: message,
//                                            preferredStyle: .alert)
//        actions.forEach { actionsheet.addAction($0) }
//        DispatchQueue.main.async {
//            viewcontroller.present(actionsheet, animated: true, completion: nil)
//        }
//    }
//}

public class Alert {
  

  
     public static func simpleAlert(message: String, title: String = "") {
          // Make sure this is executed on the main queue
          DispatchQueue.main.async {
              let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alertController.addAction(okAction)
  
            if let currentViewController = UIApplication.shared.keyWindow?.rootViewController {
                  currentViewController.present(alertController, animated: true, completion: nil)
              }
          }
      }
}


