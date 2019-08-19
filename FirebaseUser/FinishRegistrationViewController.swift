//
//  FinishRegistrationViewController.swift
//  FirebaseUser
//
//  Created by Richard Cummings on 2019-08-18.
//  Copyright © 2019 Richard Cummings. All rights reserved.
//

import UIKit

class FinishRegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    var email: String!
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("email: \(email), password: \(password)")
    }
    
    // MARK: IBActions

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishRegistrationButtonPressed(_ sender: Any) {
        if nameTextField.text != "" && surnameTextField.text != "" {
            // finish registration
            FUser.registerUserWith(email: email, password: password, name: nameTextField.text!, surname: surnameTextField.text!)
        } else {
            print("all fields are required")
        }
    }
    
    @IBAction func backgroundTap(_ sender: Any) {
        view.endEditing(false)
    }
}
