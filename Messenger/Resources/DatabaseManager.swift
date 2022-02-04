//
//  DatabaseManager.swift
//  Messenger
//
//  Created by LrUCiA.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

// MARK: - Account Management

extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping((Bool) -> Void)) {
    
        database.child(email).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else {
                return
            }
            
            completion(true)
        })
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "first_Name": user.firstName,
            "last_Name": user.lastName
            //,"profilePicture_URL": user.profilePictureUrl
        ])
    }//dictionary key로 emailAddress를 전달하기 떄문에 암호를 딱히 전달하지 않아도 된다.(emailAddress가 암호 역할)
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    // let profilePictureUrl: String
}
