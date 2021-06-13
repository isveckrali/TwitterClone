//
//  UserProfileView.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-05-29.
//

import SwiftUI



struct UserProfileView: View {
    
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(isFollowed: $viewModel.isFollowed, viewModel: viewModel)
                    .padding()
 
                ForEach(0..<9) { tweet in
                    TweetCell()
                        .padding()
                }
                //.padding() add it if not fixed
                
                
            }
            
            .navigationTitle("Batman")
        }
    }
}
