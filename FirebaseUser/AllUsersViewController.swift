//
//  AllUsersViewController.swift
//  FirebaseUser
//
//  Created by Richard Cummings on 2019-08-19.
//  Copyright © 2019 Richard Cummings. All rights reserved.
//

import UIKit

class AllUsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allUsers: [FUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUsersFromFirebase()
    }
    
    // MARK: TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    // MARK: LoadUsers
    
    func loadUsersFromFirebase() {
        Reference(.Users).getDocuments { (snapshot, error) in
            if error != nil {
                print("error loading users \(error?.localizedDescription ?? "unknown")")
            }
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                print("... we have users \(snapshot.documents.count)")
            } else {
                print("User snapshot is empty")
            }
        }
    }
}
