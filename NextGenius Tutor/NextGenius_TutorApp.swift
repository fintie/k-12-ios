//
//  NextGenius_TutorApp.swift
//  NextGenius Tutor
//
//  Created by Nicholas on 3/9/2025.
//

import SwiftUI

@main
struct NextGenius_TutorApp: App {
    @StateObject private var authService = AuthService.shared
    
    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                ContentView()
                    .environmentObject(UserManager())
            } else {
                LoginView(onLoginSuccess: {
                    // Handle successful login
                })
            }
        }
    }
}
