import SwiftUI
import FirebaseFirestore



struct RegisterView: View {
    @State var email: String = "";
    @State var password: String = "";
    @State var verifyPassword: String = "";
    @State var user: StoredUser = StoredUser(email: "", avatarImage: "", bio: "", friends: [], rooms: [], favorites: [])
    @State var path = UserProfileView()
    @State var status: FirestoreStatus = FirestoreStatus(success: false, code: 100, message: "")
        
    var body: some View {
            ZStack {
                Color(Color.offWhite)
                
                VStack {

                    HStack {
                        Text("REGISTER")
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
                    SecureField("verify password", text: $verifyPassword)
                        .accentColor(.black)
                        .padding()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled()
                    //buttons
                    HStack {
                        Button(action: {
                            print("back")
                        }, label: {
                            Text("Back")
                        })
                        .buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                        .padding()
                        
                        Button(action: {
                            if (email == "" || password == ""){
                                print("Register error: Form is incomplete.")
                            } else if (password != verifyPassword){
                                print("Passwords don't match!")
                            } else {
                                user.email = email
                                let firestore = FirestoreUser(user: $user, status: $status)
                                
                                Task {
                                    await firestore.createNewUser()
                                }
                            }
                        }, label: {
                            Text("Submit")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                    }
                    if (status.code == 100) {
                        EmptyView()
                    } else if (status.code == 500){
                        ZStack {
                            Text("ERROR")
                            Text(status.message)
                        }
                    }
                    
                }
            }.ignoresSafeArea()
        }
}

#Preview {
    RegisterView()
}
