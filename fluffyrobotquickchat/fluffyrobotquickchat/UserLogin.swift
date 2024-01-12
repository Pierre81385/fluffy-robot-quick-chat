//
//  ChatRoom_CREATE.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = "";
    @State var password: String = "";
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    print("guest")
                }, label: {
                    Text("Continue as Guest")
                })
                Text("Or Login")
                //email
                TextField("email address", text: $email)
                //password
                TextField("password", text: $password)
                //buttons
                HStack {
                    Button(action: {
                        print("back")
                    }, label: {
                        Text("Back")
                    })
                    Button(action: {
                        print("submit")
                    }, label: {
                        Text("Submit")
                        //function to try user login
                        //function to move user to the next screen
                    })
                }
            }
        }
    }
}
