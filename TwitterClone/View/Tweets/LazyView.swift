//
//  LazyView.swift
//  TwitterClone
//
//  Created by Mehmet Can Seyhan on 2021-06-17.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
