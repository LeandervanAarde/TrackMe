//
//  AuthenticationViewModel.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 09/08/2023.
//

import Foundation
import SwiftUI
import AuthenticationServices
import CryptoKit
import FirebaseAuth

enum AuthenticationState{
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow{
    case login
    case signIp
}

@MainActor
class AuthenticationViewModel : ObservableObject{
    @Published var currentNonce : String? = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    @Published var flow: AuthenticationFlow = .login

    @Published var isValid: Bool  = false
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage: String = ""
    @Published var displayName: String = ""
    @ObservedObject private var viewModel: UsersViewModel = UsersViewModel()
     
    

}

extension AuthenticationViewModel {
 
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest){
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        currentNonce = nonce
//        currentNonce = nonce
        request.nonce = sha256(nonce)
    }
    
    func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>){
        if case .failure(let failure) = result {
            errorMessage = failure.localizedDescription
        }
        else if case.success(let success) = result {
            if let appleIDCredential = success.credential as? ASAuthorizationAppleIDCredential{
                guard let nonce = currentNonce else{
                    fatalError("Invalid state: a login callback was received, but no login request was sent.")
                }
                
                guard let appleIdToken = appleIDCredential.identityToken else {
                    print("unable to fetch id token")
                    return
                }
                
                guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else{
                    print("unable to stringify")
                    return
                }
                
                let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                
                Task {
                    do {
                        if let appleIDCredential = success.credential as? ASAuthorizationAppleIDCredential {
                            print("Credential: \(appleIDCredential)")
                            // ... rest of the code ...
                        }
                        
                        let result = try await Auth.auth().signIn(with: credential)
//
                        if let fullName = appleIDCredential.fullName {
                            print("Given Name: \(fullName.givenName ?? "")")
                            print("Family Name: \(fullName.familyName ?? "")")
                            viewModel.createNewUser(userName: fullName.givenName ?? "", userId: result.user.uid)
                                                // ... rest of the code ...
                            } else {
                                print("Full Name not available")
                            }
                    }
                    catch{
                        print("error \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
}

private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  var randomBytes = [UInt8](repeating: 0, count: length)
  let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
  if errorCode != errSecSuccess {
    fatalError(
      "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
    )
  }

  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

  let nonce = randomBytes.map { byte in
    // Pick a random character from the set, wrapping around if needed.
    charset[Int(byte) % charset.count]
  }

  return String(nonce)
}


private func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}
