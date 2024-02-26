import SwiftUI
import FirebaseFirestore
import FirebaseAuth


enum Onboarding {
    case start, name, email, image, age, about, password, summary
}

struct UserRegisterView: View {
    @State var stage: Onboarding = Onboarding.start
    @State var profile: UserProfile = UserProfile(email: "", name: "", image: "", birthday: Date(), online: false, role: Role.Owner, friends: [])
    @State var password: String = ""
    @State var isReady: Bool = false

    var body: some View {
        
            ZStack {
                switch stage {
                case Onboarding.email:
                    OnboardingEmail(profile: $profile, stage: $stage)
                case Onboarding.image:
                    OnboardingImageUpload(profile: $profile, stage: $stage)
                case Onboarding.age:
                    OnboardingAge(profile: $profile, stage: $stage)
                case Onboarding.password:
                    OnboardingPassword(password: $password, stage: $stage)
                case Onboarding.summary:
                    OnboardingSummary(pw: $password, profile: $profile, stage: $stage)
                default: OnboardingName(profile: $profile, stage: $stage)
                }
            }.ignoresSafeArea()
        }
    }


#Preview {
    UserRegisterView()
}

struct OnboardingStart: View {
    @Binding var stage: Onboarding
    
    var body: some View {
        VStack {
            Button(action: {
                stage = Onboarding.name
            }, label: {
                Text("Register")
            })
        }.tint(.black)
    }
}

struct OnboardingName: View {
    @Binding var profile: UserProfile
    @Binding var stage: Onboarding
    
    var body: some View {
            VStack {
                ZStack {
                    Color.white.ignoresSafeArea()
                    VStack(alignment: .leading) {
                        Text("Name as you'd like it to appear to other users.").font(.title2)
                        HStack {
                            Image(systemName: "pencil")
                            TextField("", text: $profile.name)
                                .accentColor(.black)
                                .padding()
                                .autocapitalization(.none)
                                .autocorrectionDisabled(true)
                                .underlineTextField()
                        }
                        
                        HStack {
                           
                            Spacer()
                            
                            Button(action: {
                                stage = Onboarding.email
                            }, label: {
                                Text("Next")
                            })
                        }
                    }
                }.padding()
            }.tint(.black)
        }
    
}

struct OnboardingEmail: View {
    
    @Binding var profile: UserProfile
    @Binding var stage: Onboarding
    
    var body: some View {
        VStack {
            ZStack {
                        Color.white.ignoresSafeArea()
                        VStack(alignment: .leading) {
                            Text("What's your email address? (you'll login with this)").font(.title2)
                            HStack {
                                Image(systemName: "envelope.open.fill")
                                TextField("", text: $profile.email)
                                    .accentColor(.black)
                                    .padding()
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled(true)
                                    .underlineTextField()
                            }
                            HStack {
                                Button(action: {
                                    stage = Onboarding.name
                                }, label: {
                                    Text("Back")
                                })
                                Spacer()
                                Button(action: {
                                    stage = Onboarding.image
                                }, label: {
                                    Text("Next")
                                })
                            }
                        }.padding()
                    }
        }.tint(.black)
    }
}


struct OnboardingImageUpload: View {
    @Binding var profile: UserProfile
    @Binding var stage: Onboarding
    
    var body: some View {
        VStack {
            Text("Image upload is not yet availible.  Press 'Next'")
            HStack {
                Button(action: {
                    stage = Onboarding.email
                }, label: {
                    Text("Back")
                })
                Spacer()
                Button(action: {
                    stage = Onboarding.age
                }, label: {
                    Text("Next")
                })
            }.tint(.black)
            
            
        }
    }
}



struct OnboardingAge: View {
    @Binding var profile: UserProfile
    @Binding var stage: Onboarding

    var body: some View {
        VStack {
            ZStack {
                        Color.white.ignoresSafeArea()
                        VStack(alignment: .leading) {
                            Text("When were you born?").font(.title2)
                            DatePicker(
                                   "Start Date",
                                   selection: $profile.birthday,
                                   displayedComponents: [.date]
                               )
                               .datePickerStyle(.graphical)
                               .tint(.black)
                            HStack {
                                Button(action: {
                                    stage = Onboarding.about
                                }, label: {
                                    Text("Back")
                                })
                                Spacer()
                                Button(action: {
                                    stage = Onboarding.password
                                }, label: {
                                    Text("Next")
                                })
                            }
                        }.padding()
                    }
        }.tint(.black)
    }
}


struct OnboardingPassword: View {
    @Binding var password: String
    @Binding var stage: Onboarding

    var body: some View {
        VStack {
            ZStack {
                        Color.white.ignoresSafeArea()
                        VStack(alignment: .leading) {
                            Text("Create a password for your profile!").font(.title2)
                            HStack {
                                Image(systemName: "pencil")
                                SecureField("", text: $password).underlineTextField()
                            }
                            HStack {
                                Button(action: {
                                    stage = Onboarding.age
                                }, label: {
                                    Text("Back")
                                })
                                Spacer()
                                Button(action: {
                                    stage = Onboarding.summary
                                }, label: {
                                    Text("Next")
                                })
                            }
                        }.padding()
                    }
        }.tint(.black)
    }
}

struct OnboardingSummary: View {
    @Binding var pw: String
    @Binding var profile: UserProfile
    @Binding var stage: Onboarding
    @ObservedObject private var user = UserModel.init(userProfiles: [], userProfile: UserProfile(email: "", name: "", image: "", birthday: Date(), online: false, role: Role.Owner, friends: []), errorMessage: "", successStatus: false)
    @ObservedObject private var auth = FireAuth(authStatus: false, authErrorMessage: "")

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text(profile.name).font(.headline)
                Text(String(describing: profile.birthday)).font(.subheadline)
                Text(profile.email).textCase(.lowercase).font(.subheadline)
                Text("Everything look good?  (You can change anything later.)")
                    .padding()
                HStack{
                    
                    Button(action: {
                        stage = Onboarding.password
                    }, label: {
                        Text("Back")
                    })
                    Spacer()
                    Button(action: {
                        var lowercase = profile.email.lowercased()
                        profile.email = lowercase
                        user.addUserProfile(userProfile: profile)
                        if (user.successStatus) {
                            auth.CreateUser(username: profile.name, email: profile.email, password: pw)
                        } else {
                            print("Error creating user!")
                        }
                    }, label: {
                        Text("Submit")
                    })
                    .navigationDestination(isPresented: $auth.authStatus, destination: { UserLoginView().navigationBarBackButtonHidden(true)})
                }.tint(.black).padding()
                Spacer()
            }
        }
    }
}


