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
    @Published var userTweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        checkIfUserFollowed()
        fetchUserTweets()
        fetchLikedTweets()
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
    
    func fetchUserTweets() {
        COLLECTION_TWEETS.whereField("uid", isEqualTo: user.id).getDocuments { snaphot, _ in
            guard let documents = snaphot?.documents else { return }
            self.userTweets = documents.map({Tweet(dictionary: $0.data())})
            
            print("DEBUG: User tweets \(self.userTweets)")
        }
    }
    
    func fetchLikedTweets() {
        
        var tweets = [Tweet]()
        COLLECTION_USERS.document(user.id).collection("user-likes").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let tweetIDs = documents.map({ $0.documentID})
            
            tweetIDs.forEach { id in
                COLLECTION_TWEETS.document(id).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let tweet = Tweet(dictionary: data)
                    
                    tweets.append(tweet)
                    guard tweets.count == tweetIDs.count else {return}
                    self.likedTweets.append(tweet)
                }
            }
        }
    }
    
    func tweets(forFilter filter: TweetFilterOptions) -> [Tweet] {
        switch filter {
        case .tweets: return userTweets
        case .likes: return likedTweets
        }
    }
}
