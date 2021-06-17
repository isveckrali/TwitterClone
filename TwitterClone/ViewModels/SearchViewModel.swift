//
//  SearchViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-06-12.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.map({ User(dictionary: $0.data())})
            
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        
        let lowercasedQuery = query.lowercased()
        
        return users.filter({$0.fullname.lowercased().contains(lowercasedQuery) || $0.username.lowercased().contains(lowercasedQuery)})
    }
}


