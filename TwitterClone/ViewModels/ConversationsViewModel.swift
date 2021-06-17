//
//  ConversationsViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-06-17.
//

import Foundation

class ConversationsViewModel: ObservableObject {
    @Published var recentMessages = [Message]()
    private var recentMessagesDictionary = [String: Message]()
    
    init() {
        fetchRecentMessages()
    }
    
    func fetchRecentMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else {
            return
        }
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages")
        query.order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges else { return }
            
            changes.forEach { change in
                let messageData = change.document.data()
                let uid = change.document.documentID
                
                COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let user = User(dictionary: data)
                    self.recentMessagesDictionary[uid] = Message(user: user, dictionary: messageData)
                    self.recentMessages = Array(self.recentMessagesDictionary.values)
                }
            }
        }
        
    }
}
