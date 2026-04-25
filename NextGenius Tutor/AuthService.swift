import Foundation
import Combine

// MARK: - Authentication Models
struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct RegisterRequest: Codable {
    let username: String
    let email: String
    let password: String
}

struct AuthResponse: Codable {
    let token: String
    let user: User
}

struct AuthError: Error, LocalizedError {
    let message: String
    
    var errorDescription: String? {
        return message
    }
}

// MARK: - Authentication Service
class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        // Check if user is already logged in
        checkAuthStatus()
    }
    
    // Check if user is already authenticated
    func checkAuthStatus() {
        // In a real app, you would check for a valid token in Keychain or UserDefaults
        // For now, we'll just set to false
        isAuthenticated = false
        currentUser = nil
    }
    
    // Login user
    func login(email: String, password: String) {
        errorMessage = nil
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        NetworkService.shared.postData(endpoint: "/auth/login", data: loginRequest, responseType: AuthResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                        self?.isAuthenticated = false
                        self?.currentUser = nil
                    }
                },
                receiveValue: { [weak self] authResponse in
                    // Save token securely (in a real app, use Keychain)
                    UserDefaults.standard.set(authResponse.token, forKey: "authToken")
                    
                    // Set user and authentication status
                    self?.isAuthenticated = true
                    self?.currentUser = authResponse.user
                    
                    // Save user to UserManager
                    if let userManager = UIApplication.shared.windows.first?.rootViewController?.environmentObject(UserManager.self) as? UserManager {
                        userManager.currentUser = authResponse.user
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    // Register new user
    func register(username: String, email: String, password: String) {
        errorMessage = nil
        
        let registerRequest = RegisterRequest(username: username, email: email, password: password)
        
        NetworkService.shared.postData(endpoint: "/auth/register", data: registerRequest, responseType: AuthResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] authResponse in
                    // Save token securely (in a real app, use Keychain)
                    UserDefaults.standard.set(authResponse.token, forKey: "authToken")
                    
                    // Set user and authentication status
                    self?.isAuthenticated = true
                    self?.currentUser = authResponse.user
                }
            )
            .store(in: &cancellables)
    }
    
    // Logout user
    func logout() {
        // Remove token from secure storage
        UserDefaults.standard.removeObject(forKey: "authToken")
        
        // Reset authentication status
        isAuthenticated = false
        currentUser = nil
        
        // Reset UserManager
        if let userManager = UIApplication.shared.windows.first?.rootViewController?.environmentObject(UserManager.self) as? UserManager {
            userManager.currentUser = User(
                id: UUID().uuidString,
                username: "Guest",
                email: "",
                profilePictureURL: nil,
                bio: "",
                completedCourses: [],
                achievements: [],
                points: 0,
                completedLessons: [:]
            )
        }
    }
    
    // Get auth token
    func getAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: "authToken")
    }
}