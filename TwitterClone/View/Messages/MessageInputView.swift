//
//  MessageInputView.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-05-26.
//

import SwiftUI

struct MessageInputView: View {
    
    @Binding var messageText: String
    
    let action: () -> Void
    
    var body: some View {
        HStack {
            TextField("Message...", text: $messageText)
                .textFieldStyle(PlainTextFieldStyle())
                .frame(minHeight: 30)
            
            Button(action: action) {
                Text("Send")
                    .bold()
                    .foregroundColor(.blue)
            }
        }
    }
}
