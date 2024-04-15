//
//  AuthViewModel.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 12/4/24.
//

import Combine
import Firebase
import FirebaseAuth

enum AuthMode {
    case signIn
    case signUp
}

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isAuthenticating = false
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    @Published var mode: AuthMode = .signIn

    private var cancellables = Set<AnyCancellable>()

    func authenticate() {
        isAuthenticating = true

        switch mode {
        case .signIn:
            signIn()
        case .signUp:
            signUp()
        }
    }

    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }

            if let error = error {
                self.isAuthenticating = false
                self.errorMessage = error.localizedDescription
                return
            }

            self.isAuthenticating = false
            self.isAuthenticated = true
            self.reset()
        }
    }

    private func signUp() {
        if password != confirmPassword {
            isAuthenticating = false
            errorMessage = "Passwords do not match."
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }

            if let error = error {
                self.isAuthenticating = false
                self.errorMessage = error.localizedDescription
                reset()
                return
            }

            self.isAuthenticating = false
            self.isAuthenticated = true
            self.reset()
        }
    }

    func reset() {
        email = ""
        password = ""
        confirmPassword = ""
        errorMessage = nil
    }
}
