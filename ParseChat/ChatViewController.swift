//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Julian Test on 2/13/17.
//  Copyright © 2017 Julian Bossiere. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var chatTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(_ sender: Any) {
        var message = PFObject(className: "Message")
        message["text"] = chatTextField.text
        message.saveInBackground { (success: Bool, error: Error?) in
            if (success) {
                print("Message successfully saved! 👌👌👌")
            } else {
                let sendAlertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)
                sendAlertController.addAction(OKAction)
                self.present(sendAlertController, animated: true)
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
