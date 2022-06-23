//
//  LoginViewModel.swift
//  iosProject
//
//  Created by funghi on 2022/6/7.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    @AppStorage("log_status") var logStatus: Bool = false
    
    func loginUser()async throws{
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        logStatus = true
    }
    func sendEmail(email: String){
        Auth.auth().sendPasswordReset(withEmail: email)
    }
    func googleSignIn(){
        
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else{return }
        //Google Sign in..
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        self.isLoading = true
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: presentingViewController) { [self] user, err in
            
            if let error = err {
                self.isLoading = false
                print(error.localizedDescription)
                // ...
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                self.isLoading = false
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            // ...
            Auth.auth().signIn(with: credential){result, err in
                self.isLoading = false
                if let error = err {
                    print(error.localizedDescription)
                    // ...
                    return
                }
                guard let user = result?.user else{
                    return
                }
                print(user.displayName ?? "Success!")
                self.logStatus = true
            }
        }
    }
    func facebookLogIn(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email], completion: { loginResult in
            switch loginResult {
            case .failed(let error):
                print("\(error)")
            case .cancelled:
                print("cancelled")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("\(grantedPermissions) \(declinedPermissions)")
                print("success")
                self.logStatus = true
            }
        })
       
    }
}
