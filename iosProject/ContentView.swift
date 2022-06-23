//
//  ContentView.swift
//  iosProject
//
//  Created by funghi on 2022/6/5.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        
        NavigationView{
            if logStatus{
                Home()
            }
            else{
                LoginPage()
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
