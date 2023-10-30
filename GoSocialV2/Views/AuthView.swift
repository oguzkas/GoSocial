//
//  AuthView.swift
//  GoSocialV2
//
//  Created by Oğuz  on 28.10.2023.
//

import SwiftUI

struct AuthView: View {
    @AppStorage("uid") var userID: String = ""
    @State private var currentViewShowing: String = "login"
    var body: some View {
        if (currentViewShowing == "login") {
            LoginView(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.light)
        }else{
            SignUpView(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.dark)
                .transition(.move(edge: .bottom))
        }
    }
}

#Preview {
    AuthView()
}
