//
//  TweetActionViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-06-15.
//

import SwiftUI
import Firebase

class TweetActionViewModel: ObservableObject {
    
    let tweet: Tweet
    @Published var didLike = false
    
    init(tweet: Tweet) {
        self.tweet = tweet
        checkfIfUserLikedTweet()
    }
    
    func likeTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let tweetLikesRef = COLLECTION_TWEETS.document(tweet.id).collection("tweet-likes")
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        COLLECTION_TWEETS.document(tweet.id).updateData(["likes": tweet.likes + 1]) {_ in
            tweetLikesRef.document(uid).setData([:]) { _ in
                userLikesRef.document(self.tweet.id).setData([:]) { _ in
                    self.didLike = true
                }
            }
        }

    }
    
    func unlikeTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let tweetLikesRef = COLLECTION_TWEETS.document(tweet.id).collection("tweet-likes")
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        COLLECTION_TWEETS.document(tweet.id).updateData(["likes": tweet.likes - 1]) {_ in
            tweetLikesRef.document(uid).delete { _ in
                userLikesRef.document(self.tweet.id).delete { _ in
                    self.didLike = false
                }
            }
        }
        
    }
    
    func checkfIfUserLikedTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes").document(tweet.id)
        userLikesRef.getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            self.didLike = didLike
        }
    }
    
}
