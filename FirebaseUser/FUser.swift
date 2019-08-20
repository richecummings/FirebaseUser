//
//  FUser.swift
//  FirebaseUser
//
//  Created by Richard Cummings on 2019-08-18.
//  Copyright © 2019 Richard Cummings. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FUser {
    var name: String
    var surname: String
    var fullName: String
    var email: String
    var userId: String
    
    init(_userId: String, _name: String, _surname: String, _email: String) {
        name = _name
        surname = _surname
        fullName = name + " " + surname
        email = _email
        userId = _userId
    }
    
    init(userDictionary: NSDictionary) {
        if let name = userDictionary["name"] {
            self.name = name as! String
        } else {
            self.name = "unknown"
        }
        if let surname = userDictionary["surname"] {
            self.surname = surname as! String
        } else {
            self.surname = "unknown"
        }
        if let email = userDictionary["email"] {
            self.email = email as! String
        } else {
            self.email = "unknown"
        }
        if let userId = userDictionary["userId"] {
            self.userId = userId as! String
        } else {
            self.userId = "unknown"
        }
        self.fullName = self.name + " " + self.surname
    }
    
    class func registerUserWith(email: String, password: String, name: String, surname: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (firebaseUser, error) in
            if error != nil {
                print("Error registering user \(error!.localizedDescription)")
                return
            }
            
            let fUser = FUser(_userId: firebaseUser!.user.uid, _name: name, _surname: surname, _email: email)
            
            fUser.saveUserToFireStore()
        }
        
    }
    
    class func loginUserWith(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (firUser, error) in
            if error != nil {
                print("error logging in \(error!.localizedDescription)")
            }
            
            self.fetchUserWithId(userId: firUser!.user.uid)
        }
    }
    
    class func fetchUserWithId(userId: String) {
        Reference(.Users).document(userId).getDocument { (snapshot, error) in
            if error != nil {
                print("error fetching user \(error!.localizedDescription)")
            }
            
            guard let snapshot = snapshot else { return }
            
            if snapshot.exists {
                let userDictionary = snapshot.data()
                let user = FUser(userDictionary: userDictionary as! NSDictionary)
                
            }
        }
    }
    
    func saveUserToFireStore() {
        Reference(.Users).document(userId).setData(dictionaryFromFUser() as! [String : Any],
           completion: { (error) in
            if error != nil {
                print ("error saving to firestore \(error!.localizedDescription)")
            }
            
            print("created user in firestore")
        })
    }
    
    func dictionaryFromFUser() -> NSDictionary {
        return NSDictionary(objects: [userId, name, surname, fullName, email],
                            forKeys: ["userId" as NSCopying, "name" as NSCopying, "surname" as NSCopying, "fullName" as NSCopying, "email" as NSCopying])
    }
}
