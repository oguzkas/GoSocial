//
//  SignUpView.swift
//  GoSocialV2
//
//  Created by Oğuz  on 28.10.2023.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @AppStorage("uid") var userID: String = ""
    @Binding var currentShowingView: String
    @State var email = ""
    @State var password = ""
    var body: some View {
        
        ZStack {
            Color.clear
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    Text("Create an account!")
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
                        .foregroundStyle(.white)
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
                        .foregroundStyle(.white)
                )
                .padding()
                
                Button(action: {
                    withAnimation {
                        self.currentShowingView = "login"
                    }
                }, label: {
                    Text("Already have an account?")
                        .foregroundStyle(.white).opacity(0.7)
                        .font(.title2)
                })
                Spacer()
                Spacer()
                Button(action: {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print(error)
                            return
                        }
                        if let authResult = authResult {
                            print(authResult.user.uid)
                            userID = authResult.user.uid
                            
                        }
                    }
                }, label: {
                    Text("Create New Account")
                        .foregroundStyle(.black)
                        .bold()
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                        )
                        .padding(.horizontal)
                        .shadow(radius: 10)
                })
            }
        }
    }
}

