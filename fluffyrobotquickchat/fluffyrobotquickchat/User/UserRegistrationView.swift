import SwiftUI
import FirebaseFirestore



struct UserRegisterView: View {
    @State var email: String = "";
    @State var password: String = "";
    @State var verifyPassword: String = "";
    @State var user: StoredUser = StoredUser(email: "", avatarImage: "", bio: "", friends: [], rooms: [], favorites: [])
    @State var status: FirebaseStatus = FirebaseStatus(success: false, code: 100, message: "")

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
                        Button(action: {
                            if (email == "" || password == ""){
                                status.success = false
                                status.code = 500
                                status.message = "Error: Registration form is incomplete."
                            } else if (password != verifyPassword){
                                status.success = false
                                status.code = 500
                                status.message = "Error: Passwords must match!."
                            } else {
                                user.email = email
                                let firestore = FirestoreUser(user: $user, status: $status)
                                
                                Task {
                                    await firestore.createNewUser()
                                }
                                
                                let auth = FireAuth(authStatus: $status)
                                auth.CreateUser(email: email, password: password)
                                //navigate to UserProfileView()
                            }
                        }, label: {
                            Text("Submit")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                
                    if (status.code != 100){
                        Text("Error \(status.code)")
                        Text(status.message)

                    }
                    
                    
                }
            }.ignoresSafeArea()
        }
            
        
    }


//#Preview {
//    UserRegisterView()
//}
