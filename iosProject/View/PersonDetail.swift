//
//  personDetail.swift
//  iosProject
//
//  Created by funghi on 2022/6/22.
//

import SwiftUI
import Firebase

struct PersonDetail: View {
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        VStack{
            if logStatus{
                Text("Logged In")
                
                Button("Logut"){
                    try? Auth.auth().signOut()
                    logStatus = false
                }
            }
            else{
                Text("Came as Guest")
            }
        }
    }
}

struct personDetail_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetail()
    }
}
