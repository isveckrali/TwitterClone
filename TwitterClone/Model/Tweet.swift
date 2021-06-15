//
//  Tweet.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-06-15.
//

import Firebase

struct Tweet: Identifiable {
    
    let id: String
    let username: String
    let profileImageUrl: String
    let fullname: String
    let caption: String
    let likes: Int
    let uid: String
    let timestamp: Timestamp
    
    
    init(dictionary: [String: Any]) {
        
        self.id = dictionary["id"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.uid = dictionary["uid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
    }
}
