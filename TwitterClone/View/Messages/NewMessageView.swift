//
//  NewMessageView.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-05-29.
//

import SwiftUI

struct NewMessageView: View {
    
    @State var searchText = ""
    @Binding var show: Bool
    @Binding var startChat: Bool
    @Binding var isEditing: Bool
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(viewModel.users) { user in
                    HStack { Spacer() }
                    Button(action: {
                        self.show.toggle()
                        self.startChat.toggle()
                    }, label: {
                        UserCell(user: user)
                    })
                }
            }.padding(.leading)
        }

    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(show: .constant(true), startChat: .constant(true), isEditing: .constant(true))
    }
}
