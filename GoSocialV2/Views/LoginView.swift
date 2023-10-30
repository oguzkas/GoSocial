//
//  LoginView.swift
//  GoSocialV2
//
//  Created by Oğuz  on 28.10.2023.
//

import SwiftUI
import FirebaseAuth
struct LoginView: View {
    @AppStorage("uid") var userID: String = ""
    @Binding var currentShowingView: String
    @State var email = ""
    @State var password = ""
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    Text("Welcome Back!")
                        .font(.largeTitle)
                    .bold()
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                HStack {
                    
                    Text("GoSocial")
                        .font(.title)
                    .bold()
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                Spacer()
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                    Spacer()
                }
                .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1.5)
                    .foregroundStyle(.black)
                )
                .padding()
                HStack{
                    Image(systemName: "lock")
                    TextField("Password", text: $password)
                        .textInputAutocapitalization(.never)
                    Spacer()
                }
                .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1.5)
                    .foregroundStyle(.black)
                )
                .padding()
                
                Button(action: {
                    withAnimation {
                        self.currentShowingView = "signup"
                    }
                }, label: {
                    Text("Don't have an account?")
                        .foregroundStyle(.black).opacity(0.7)
                        .font(.title2)
                        .shadow(radius: 10)
                })
                Spacer()
                Spacer()
                Button(action: {
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print(error)
                            return
                        }
                        if let authResult = authResult {
                            print(authResult.user.uid)
                            withAnimation {
                                userID = authResult.user.uid
                            }
                        }
                    }
                }, label: {
                    Text("Sign In")
                        .foregroundStyle(.white)
                        .bold()
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                        )
                        .padding(.horizontal)
                        .shadow(radius: 10)
                })
            }
        }
    }
}
