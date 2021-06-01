//
//  FeedView.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-05-26.
//

import SwiftUI

struct FeedView: View {
    
    @State var isShowingNewTweetView = false
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                 VStack {
                    ForEach(0..<20) { _ in
                        TweetCell()
                    }
                 }.padding()
            }
            
            Button(action: {
                isShowingNewTweetView.toggle()
            }, label: {
                Image("tweet")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $isShowingNewTweetView){
                NewTweetView(isPresented: $isShowingNewTweetView)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
