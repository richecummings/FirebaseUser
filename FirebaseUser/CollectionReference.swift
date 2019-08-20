//
//  CollectionReference.swift
//  FirebaseUser
//
//  Created by Richard Cummings on 2019-08-19.
//  Copyright © 2019 Richard Cummings. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case Users
}

func Reference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
