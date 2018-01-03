//
//  NewMessageController.swift
//  gameofchats
//
//  Created by _joelvieira on 29/12/2017.
//  Copyright © 2017 _joelvieira. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    var users = [FIRUser]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: "cellId")
        
        fetchUser()

    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : Any] {
                let user = FIRUser()
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                self.users.append(user)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }

}

class UserCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
