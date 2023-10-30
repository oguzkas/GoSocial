//
//  ContentView.swift
//  GoSocialV2
//
//  Created by Oğuz  on 28.10.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("uid") var userID: String = ""
    var body: some View {
        if userID .isEmpty{
            AuthView()
        }else{
            FeedView()
        }
    }
}

#Preview {
    ContentView()
}
