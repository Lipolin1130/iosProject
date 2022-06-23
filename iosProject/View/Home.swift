//
//  Home.swift
//  iosProject
//
//  Created by funghi on 2022/6/7.
//

import SwiftUI
import Firebase

struct Home: View {
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
//        VStack(spacing: 20){
//            if logStatus{
//                Text("Logged In")
//
//                Button("Logut"){
//                    try? Auth.auth().signOut()
//                    logStatus = false
//                }
//            }
//            else{
//                Text("Came as Guest")
//            }
//        }
        TabView{
            Map().tabItem {
                NavigationLink(destination: Map()) {
                    Image(systemName: "car")
                    Text("Trips") }
            }
            Map().tabItem {
                NavigationLink(destination: Map()) {
                    Image(systemName: "car")
                    Text("Trips") }
            }
            Map().tabItem {
                NavigationLink(destination: Map()) {
                    Image(systemName: "map.fill")
                    Text("Map") }
            }
            Map().tabItem {
                NavigationLink(destination: Map()) {
                    Image(systemName: "car")
                    Text("Trips") }
            }
            PersonDetail().tabItem {
                NavigationLink(destination: PersonDetail()) {
                    Image(systemName: "person.fill")
                    Text("info") }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
