//
//  User.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-06-12.
//

import Firebase

struct User: Identifiable {
    
    let id: String
    let username: String
    let profileImageUrl: String
    let fullname: String
    let email: String
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
    }
}
