//
//  ProfileActionButtonView.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-05-29.
//

import SwiftUI

struct ProfileActionButtonView: View {
    
    let viewModel: ProfileViewModel
    @Binding var isFollowed: Bool
    
    var body: some View {
        
        if viewModel.user.isCurrentUser {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Edit Profile")
                    .frame(width: 360, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
            })
            .cornerRadius(20)
        } else {
            HStack {
                Button(action: {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                }, label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .frame(width: 180, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                })
                .cornerRadius(20)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Message")
                        .frame(width: 180, height: 40)
                        .background(Color.purple)
                        .foregroundColor(.white)
                })
                .cornerRadius(20)
            }
        }
        
       
    }
}
