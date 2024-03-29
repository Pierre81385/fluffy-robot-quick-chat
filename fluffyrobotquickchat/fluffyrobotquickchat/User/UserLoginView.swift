//
//  ChatRoom_CREATE.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct UserLoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var showRegistration: Bool = false
    @ObservedObject var auth = FireAuth(authStatus: false, authErrorMessage: "")
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color.white)
                VStack {
                    HStack {
                       
                    
                            VStack{
                                Text("LOGIN")
                                    .font(.largeTitle)
                                Text(auth.authErrorMessage).tint(.red)
                            }
                        
                    }
                    //email
                    TextField("email address", text: $email)
                        .accentColor(.black)
                        .padding()
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)                    //password
                    SecureField("password", text: $password)
                        .accentColor(.black)
                        .padding()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled(true)
                    //buttons
                    
                    
                        Button(action: {
                            var lowercase = email.lowercased()
                            email = lowercase
                            auth.SignInWithEmailAndPassword(email: email, password: password)
                        }, label: {
                            Text("Submit")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                            .navigationDestination(isPresented: $auth.authStatus, destination: {UserMain()})
                
                    Divider().padding()
                    
                    Button(action: {
                        showRegistration = true
                    }, label: {
                        Text("Create New account")
                    }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                        .padding()
                        .navigationDestination(isPresented: $showRegistration, destination: {UserRegisterView()})
                    
                }
            }.onAppear{
                email = ""
                password = ""
                auth.authErrorMessage = ""
            }
            .ignoresSafeArea()
                
        }.accentColor(.black)
            

    }
}

#Preview {
    UserLoginView()
}

struct LoginEnd: View {

    var body: some View {
        VStack {
            Text("Success!")
        }
    }
}
                
                
