//
//  MessagesController.swift
//  gameofchats
//
//  Created by _joelvieira on 26/12/2017.
//  Copyright © 2017 _joelvieira. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "new_message_icon"), style: .plain, target: self, action: #selector(handleNewMessage))
        
        checkIfUserLoggedIn()
        
    }
    
    @objc func handleNewMessage() {
        let navigationController = UINavigationController(rootViewController: NewMessageController())
        present(navigationController, animated: true, completion: nil)
    }
    
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String:Any] {
                    self.navigationItem.title = dictionary["name"] as? String
                }
            })
        }
    }
    
    @objc func handleLogout() {
        
        do {
            try? Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }



}

