//
//  LoginViewController.swift
//  FirebaseUser
//
//  Created by Richard Cummings on 2019-08-18.
//  Copyright © 2019 Richard Cummings. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginSegmentOutlet: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: IBActions
    
    @IBAction func loginSegmentValueChanged(_ sender: UISegmentedControl) {
        cleanTextFields()
        if sender.selectedSegmentIndex == 0 {
            // login
            UIView.animate(withDuration: 0.2) {
                self.confirmPasswordTextField.isHidden = true
                self.loginViewHeightConstraint.constant = self.loginViewHeightConstraint.constant - 40.0
                self.loginButtonOutlet.setTitle("Login", for: .normal)
            }
        } else {
            // sign up
            UIView.animate(withDuration: 0.2) {
                self.confirmPasswordTextField.isHidden = false
                self.loginViewHeightConstraint.constant = self.loginViewHeightConstraint.constant + 40.0
                self.loginButtonOutlet.setTitle("Register", for: .normal)
            }
        }
        loginView.layoutIfNeeded()
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if loginSegmentOutlet.selectedSegmentIndex == 0 {
            if emailTextField.text != "" && passwordTextField.text != "" {
                loginUser()
            } else {
                showAlert(title: "Warning", text: "All fields are required")
            }
        } else {
            registerNewUser()
            
            if emailTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != "" {
                if passwordTextField.text == confirmPasswordTextField.text {
                    
                } else {
                    showAlert(title: "Warning", text: "Passwords don't match")
                }
            } else {
                showAlert(title: "Warning", text: "All fields are required")
            }
        }
    }
    
    @IBAction func backgroundTap(_ sender: Any) {
    }
    
    // MARK: SetupUI
    
    func setupUI() {
        confirmPasswordTextField.isHidden = true
        loginViewHeightConstraint.constant = loginViewHeightConstraint.constant - 40.0
        loginView.layer.cornerRadius = 10
        loginView.layer.shadowColor = UIColor.gray.cgColor
        loginView.layer.shadowOffset = CGSize.zero
        loginView.layer.shadowOpacity = 1.0
        loginView.layer.shadowRadius = 7.0
        
        let emailImageView = UIImageView(image: UIImage(named: "email"))
        emailImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        emailImageView.contentMode = .scaleAspectFit
        
        emailTextField.leftViewMode = .always
        emailTextField.leftView = emailImageView
        
        let passwordImageView = UIImageView(image: UIImage(named: "password"))
        passwordImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        passwordImageView.contentMode = .scaleAspectFit
        
        passwordTextField.leftViewMode = .always
        passwordTextField.leftView = passwordImageView
        
        let confirmPasswordImageView = UIImageView(image: UIImage(named: "password"))
        confirmPasswordImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        confirmPasswordImageView.contentMode = .scaleAspectFit
        
        confirmPasswordTextField.leftViewMode = .always
        confirmPasswordTextField.leftView = confirmPasswordImageView
    }
    
    func cleanTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
    
    // MARK: Login/Registration
    func registerNewUser() {
        print("register")
        performSegue(withIdentifier: "loginToFinishRegSegue", sender: self)
    }
    
    func loginUser() {
        FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    // MARK: Alert
    
    func showAlert(title: String, text: String) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToFinishRegSegue" {
            let finishRegVC = segue.destination as! FinishRegistrationViewController
            finishRegVC.email = emailTextField.text
            finishRegVC.password = passwordTextField.text
        }
    }
    
}
