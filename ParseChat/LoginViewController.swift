//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Julian Test on 2/13/17.
//  Copyright © 2017 Julian Bossiere. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var alertController: UIAlertController!
    var OKAction: UIAlertAction!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        alertController = UIAlertController(title: "Username, Email and Password Required", message: "Please enter a username, email address and password", preferredStyle: .alert)
        OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if (usernameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "") {
            present(alertController, animated: true)
            
        } else {
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
                if user != nil {
                    print("user logged in")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                } else {
                    print("error: \(error?.localizedDescription) ")
                    let loginAlertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    loginAlertController.addAction(self.OKAction)
                    self.present(loginAlertController, animated: true)
                }
            }
        }
    }

    @IBAction func onSignUp(_ sender: Any) {
        if (usernameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "") {
            present(alertController, animated: true)
        } else {
            let user = PFUser()
            user.username = usernameTextField.text
            user.email = emailTextField.text
            user.password = passwordTextField.text
            
            user.signUpInBackground { (succeeded: Bool, error: Error?) in
                if let error = error {
                    let signupAlertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    signupAlertController.addAction(self.OKAction)
                    self.present(signupAlertController, animated: true)
                } else {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
