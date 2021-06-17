//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-06-15.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        COLLECTION_TWEETS.getDocuments { snaphot, _ in
            guard let documents = snaphot?.documents else { return }
            self.tweets = documents.map({Tweet(dictionary: $0.data())})
            print("DEBUG: Tweets \(self.tweets)")
        }
    }
}
