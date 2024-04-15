//
//  AuthView.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 12/4/24.
//

import SwiftUI
import Combine

struct AuthView: View {
    @ObservedObject var viewModel = ViewModelProvaider.viewModelAuhtView()
    @State private var showAlert = false

    var body: some View {
        VStack {
            if viewModel.isAuthenticating {
                ProgressView()
            } else if !viewModel.isAuthenticated {
                VStack {
                    Text("Rick and Morty")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                        .padding()
                    Image("home")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200.0, height: 200.0)
                    Picker("Mode", selection: $viewModel.mode) {
                        Text("Sign In").tag(AuthMode.signIn)
                        Text("Sign Up").tag(AuthMode.signUp)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("Email", text: $viewModel.email)
                        .padding([.top, .leading, .bottom], 5.0)
                        .autocapitalization(.none)
                        .background(Color(red: 220/255, green: 220/255, blue: 220/255))
                        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    SecureField("Password", text: $viewModel.password)
                        .padding([.top, .leading, .bottom], 5.0)
                        .background(Color(red: 220/255, green: 220/255, blue: 220/255))
                        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    if viewModel.mode == .signUp {
                        SecureField("Confirm Password", text: $viewModel.confirmPassword)
                            .padding([.top, .leading, .bottom], 5.0)
                            .background(Color(red: 220/255, green: 220/255, blue: 220/255))
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    }
                    Button(action: {
                        viewModel.authenticate()
                    }) {
                        Text(viewModel.mode == .signIn ? "Sign In" : "Sign Up")
                            .foregroundColor(.white)
                    }
                    .padding(0.0)
                    .frame(width: 100.0, height: 40.0)
                    .background(Color.black)
                    .cornerRadius(/*@START_MENU_TOKEN@*/6.0/*@END_MENU_TOKEN@*/)
                }
                .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
                .background(Color.white)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                }
                .onReceive(viewModel.$errorMessage) { errorMessage in
                    if errorMessage != nil {
                        showAlert = true
                    }
                }
            }
            
            if viewModel.isAuthenticated {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(
                            colors: [Color.gray, Color.black]),
                        startPoint: .top,
                        endPoint: .bottom)
                    .ignoresSafeArea()
                    VStack {
                        Text("Authentication successful!")
                            .padding()
                            .foregroundColor(.black)
                        Button(action: {
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let window = windowScene.windows.first {
                                window.rootViewController = UIHostingController(rootView: MainView())
                            }
                        }) {
                            Text("ok")
                                .foregroundColor(.white)
                        }
                        .padding(0.0)
                        .frame(width: 100.0, height: 40.0)
                        .background(Color.black)
                        .cornerRadius(/*@START_MENU_TOKEN@*/6.0/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.all, 10.0)
                    .background(Color.white)
                }
                
            }
        }
                
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
