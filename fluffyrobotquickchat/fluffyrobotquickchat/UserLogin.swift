//
//  ChatRoom_CREATE.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import SwiftUI
import FirebaseFirestore

struct UserLoginView: View {
    @State var email: String = "";
    @State var password: String = "";
    
    var body: some View {

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
                    .autocorrectionDisabled()
                //password
                SecureField("password", text: $password)
                    .accentColor(.black)
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                //buttons
                HStack {
                    Button(action: {
                        if (email == "" || password == ""){
                            print("Login error: Form is incomplete.")
                        } else {
                            let user = FirestoreUser()
                            
                            Task {
                                await user.createNewUser(email: email, password: password)
                            }
                        }
                        
                        
                    }, label: {
                        Text("Submit")
                        //function to create DB record of users
                        //function to move user to the next screen
                    }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                        .padding()
                }
                Divider().padding()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("I'm a new user")
                        .foregroundColor(.black)
                })
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    UserLoginView(email: "", password: "")
}