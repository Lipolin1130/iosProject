//
//  LoginPage.swift
//  iosProject
//
//  Created by funghi on 2022/6/7.
//

import SwiftUI


struct LoginPage: View {
    
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    
    
    var body: some View {
        
        VStack{
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.vertical, 45)
            
            HStack{
                Image(systemName: "envelope")
                TextField("Email", text: $loginModel.email)
                    .textInputAutocapitalization(.never)
            }
            .padding(20)
            .background{
                RoundedRectangle(cornerRadius: 9)
                    .fill(
                        loginModel.email == "" ? Color.black.opacity(0.05) : Color.blue.opacity(0.1)
                    )
            }
            .padding(.top, 20)
            
            HStack{
                Image(systemName: "lock")
                SecureField("password", text: $loginModel.password)
                    .textInputAutocapitalization(.never)
            }
            .padding(20)
            .background{
                RoundedRectangle(cornerRadius: 9)
                    .fill(
                        loginModel.password == "" ? Color.black.opacity(0.05) : Color.blue.opacity(0.1)
                    )
            }
            .padding(.top, 15)
            
            Button {
                alertTF(title: "Help", message: "Please type your email.\n We will send a reset mail to you", hintText: "example@gmail.com", primaryTitle: "Send", secondaryTitle: "Cancel"){email in
                    
                    loginModel.sendEmail(email: email)
                    
                }secondaryAction: {
                    print("cancel")
                }
            } label: {
                Text("Forgot your password?")
                    .font(.footnote)
                    .underline()
                    .foregroundColor(Color.gray)
                    .padding(.top, 15)
            }
            
            Button {
                Task{
                    do{
                        try await loginModel.loginUser()
                    }
                    catch{
                        loginModel.errorMsg = error.localizedDescription
                        loginModel.showError.toggle()
                    }
                }
            } label: {
                Text("Sign In")
                    .padding()
                    .font(.title2)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }
            .padding(.vertical, 15)
            .disabled(loginModel.email == "" || loginModel.password == "")
            .opacity(loginModel.email == "" || loginModel.password == "" ? 0.5 : 1)
            HStack{
                Text("Or")
            }
            HStack(spacing: 50){
                
                Button {
                    loginModel.googleSignIn()
                } label: {
                    Image("googleLogo")
                        .resizable()
                        .frame(width: 35, height: 35)
                    
                }
                Button {
                    loginModel.facebookLogIn()
                } label: {
                    Image("facebookLogo")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
                Button {
                    
                } label: {
                    Image("appleLogo")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
            }
            .padding(10)
        }
        .padding(.horizontal, 25)
        .padding(.vertical)
        .alert(loginModel.errorMsg, isPresented: $loginModel.showError){}
        .overlay(
            ZStack{
                if loginModel.isLoading{
                    Color.black
                        .opacity(0.25)
                        .ignoresSafeArea()
                    ProgressView()
                        .font(.title2)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}


extension View{
    func alertTF(title: String, message: String, hintText: String, primaryTitle: String, secondaryTitle: String, primaryAction: @escaping(String)->(), secondaryAction: @escaping()->()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField{field in
            field.placeholder = hintText
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: {_ in
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: {_ in
            if let text = alert.textFields?[0].text{
                primaryAction(text)
            }
            else{
                primaryAction("")
            }
        }))
        rootController().present(alert, animated: true, completion: nil)
    }
    
    func rootController()->UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
}
