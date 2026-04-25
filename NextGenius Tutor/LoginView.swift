import SwiftUI

struct LoginView: View {
    @StateObject private var authService = AuthService.shared
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var username = ""
    @State private var showingAlert = false
    
    var onLoginSuccess: () -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Spacing.large) {
                    // Logo/Header
                    VStack(spacing: Spacing.medium) {
                        Image(systemName: "brain.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.primary)
                        
                        Text("NextGenius Tutor")
                            .font(Typography.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(isRegistering ? "Create an account" : "Sign in to your account")
                            .font(Typography.body)
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.bottom, Spacing.extraLarge)
                    
                    // Form
                    VStack(spacing: Spacing.medium) {
                        if isRegistering {
                            TextField("Username", text: $username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                        }
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        if !isRegistering {
                            HStack {
                                Spacer()
                                Button("Forgot Password?") {
                                    // Handle forgot password
                                }
                                .font(Typography.caption)
                            }
                        }
                    }
                    
                    // Action Button
                    Button(action: {
                        if isRegistering {
                            register()
                        } else {
                            login()
                        }
                    }) {
                        Text(isRegistering ? "Create Account" : "Sign In")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    
                    // Toggle between login and register
                    Button(action: {
                        isRegistering.toggle()
                    }) {
                        Text(isRegistering ? "Already have an account? Sign In" : "Don't have an account? Register")
                            .font(Typography.body)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical)
                    
                    // Error message
                    if let errorMessage = authService.errorMessage {
                        Text(errorMessage)
                            .font(Typography.caption)
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(CornerRadius.small)
                    }
                }
                .padding()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    
    private func login() {
        authService.login(email: email, password: password)
    }
    
    private func register() {
        authService.register(username: username, email: email, password: password)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(onLoginSuccess: {})
    }
}