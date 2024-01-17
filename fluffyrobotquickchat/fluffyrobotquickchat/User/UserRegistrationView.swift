import SwiftUI
import FirebaseFirestore
import FirebaseAuth



struct UserRegisterView: View {
    @State var email: String = "";
    @State var password: String = "";
    @State var verifyPassword: String = "";
    @State var status: FirebaseStatus = FirebaseStatus(success: false, code: 100, message: "")
    @State var user: User?

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
                                let auth = FireAuth(authStatus: $status)
                                auth.CreateUser(email: email, password: password)
                            }
                        }, label: {
                            Text("Submit")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                            .navigationDestination(isPresented: $status.success, destination: {UserProfileView(user: user)})
                
                    if (status.code != 100){
                        Text("Error \(status.code)")
                        Text(status.message)

                    }
                    
                    
                }
            }.ignoresSafeArea()
        }
            
        
    }


#Preview {
    UserRegisterView()
}
