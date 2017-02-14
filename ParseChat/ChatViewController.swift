//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Julian Test on 2/13/17.
//  Copyright © 2017 Julian Bossiere. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: "onTimer", userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(_ sender: Any) {
        let message = PFObject(className: "Message")
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
    
    func onTimer() {
        var query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.includeKey("text")
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) in
            if let messages = messages {
                self.messages = messages
            } else {
                print("error: \(error?.localizedDescription)")
            }
        }
        tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages != nil {
            return messages!.count
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTableViewCell
        let returnedObject = messages?[indexPath.row]
        let message = returnedObject?["text"]
        
        cell.messageBodyLabel.text = "\(message!)"
        
        return cell
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
