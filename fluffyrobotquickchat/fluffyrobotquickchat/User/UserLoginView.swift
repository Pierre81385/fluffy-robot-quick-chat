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
    @State var email: String = "";
    @State var password: String = "";
    @State var status: FirebaseStatus = FirebaseStatus(success: false, code: 100, message: "")
    @State var showDial: Bool = false
    @State var user: User?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color.offWhite)
                VStack {
                    HStack {
                        Text("LOGIN")
                            .font(.largeTitle)
                    }
                    //email
                    TextField("email address", text: $email)
                        .accentColor(.black)
                        .padding()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled(true)                    //password
                    SecureField("password", text: $password)
                        .accentColor(.black)
                        .padding()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled(true)
                    //buttons
                    
                    HStack {
                        Button(action: {
                            showDial = true
                        }, label: {
                            Text("Enter Code")
                        })
                        .sheet(isPresented: $showDial, content: {
                            DialView()
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                        Button(action: {
                            if (email == "" || password == ""){
                                status.success = false
                                status.code = 300
                                status.message = "Email and password is required to login!"
                            } else {
                                let auth = FireAuth(authStatus: $status)
                                auth.SignInWithEmailAndPassword(email: email, password: password)
                            }
                            
                        }, label: {
                            Text("Submit")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                            .navigationDestination(isPresented: $status.success, destination: {UserProfileView(user: user)})

                    }
                    if (status.code != 100){
                        Text(String(describing: status.code))
                        Text(status.message)
                    }
                    Divider().padding()
                    NavigationLink(destination: {UserRegisterView()}, label: {Text("I'm a new user!").foregroundColor(.black)})
                }
            }.ignoresSafeArea()
        }.accentColor(.black)
            

    }
}

#Preview {
    UserLoginView()
}
