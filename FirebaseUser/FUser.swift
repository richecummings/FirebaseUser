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
            
            print("User logged in with \(String(describing: firUser?.user.email))")
        }
    }
    
    func saveUserToFireStore() {
        Firestore.firestore().collection("Users").document(userId).setData(dictionaryFromFUser() as! [String : Any],
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
