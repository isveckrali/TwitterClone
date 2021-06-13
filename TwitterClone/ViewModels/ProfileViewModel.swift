//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-06-13.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    let user: User
    @Published var isFollowed = false
    
    init(user: User) {
        self.user = user
        checkIfUserFollowed()
    }
    
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            return 
        }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        
        followingRef.document(user.id).setData([:]) { _ in
            followersRef.document(currentUid).setData([:]) { _ in
                self.isFollowed =  true
            }
        }
    }
    
    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        
        followingRef.document(currentUid).delete { _ in
            followersRef.document(currentUid).delete { _ in
                self.isFollowed = false
            }
        }
    }
    
    func checkIfUserFollowed() {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        
        followingRef.document(user.id).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else {return}
            self.isFollowed = isFollowed
        }
    }
}
