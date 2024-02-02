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
    @ObservedObject private var userModel = UserModel.init(userDocs: [], user: UserDoc(email: "", name: ""), errorMessage: "")

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
                            name = ""
                            email = ""
                            password = ""
                            verifyPassword = ""
                            let user: UserDoc = UserDoc(email: email, name: name)
                            userModel.addUser(user: user)
                            let auth = FireAuth(authStatus: $status)
                            auth.CreateUser(username: name, email: email, password: password)
                        }, label: {
                            Text("Submit")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                        .padding()
                        .navigationDestination(isPresented: $status.success, destination: {UserProfileView()})

                    
                }
            }.ignoresSafeArea()
        }
    }


#Preview {
    UserRegisterView()
}
