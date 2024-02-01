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
    @State var status: FireAuthStatus = FireAuthStatus(success: false, code: 0, message: "")
    @State var user: UserDoc = UserDoc(email: "", name: "")
    @ObservedObject private var userModel = UserModel.init(userDocs: [], user: UserDoc(email: "", name: ""), errorMessage: "")
    
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
                            let auth = FireAuth(authStatus: $status)
                            auth.SignInWithEmailAndPassword(email: email, password: password)
                        }, label: {
                            Text("Submit")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                            .navigationDestination(isPresented: $status.success, destination: {UserProfileView()})

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
