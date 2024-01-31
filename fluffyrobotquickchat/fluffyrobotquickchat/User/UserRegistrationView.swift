import SwiftUI
import FirebaseFirestore
import FirebaseAuth



struct UserRegisterView: View {
    @State var email: String = "";
    @State var password: String = "";
    @State var name: String = "";
    @State var verifyPassword: String = "";
    @State var submit: Bool = false
    @State var status: FireAuthStatus = FireAuthStatus(success: false, code: 0, message: "")
    @ObservedObject private var userModel = UserModel()

    var body: some View {
        
            ZStack {
                Color(Color.offWhite)
                
                VStack {
                    
                    HStack {
                        Text("REGISTER")
                            .font(.largeTitle)
                    }
                    TextField("name", text: $name)
                        .accentColor(.black)
                        .padding()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled()
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
                        Button(action: {
                            //create Firebase Auth User
                            let auth = FireAuth(authStatus: $status)
                            auth.CreateUser(username: name, email: email, password: password)
                            //create Firebase Firestore User document
                            Task {
                                await userModel.createUserDocument(name: name, email: email, uid: auth.GetCurrentUser().uid)
                            }
                            if (status.success){
                                submit = true
                            }
                        }, label: {
                            Text("Submit")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                            .navigationDestination(isPresented: $submit, destination: {UserProfileView()})
                    
                }
            }.ignoresSafeArea()
        }
    }


#Preview {
    UserRegisterView()
}
