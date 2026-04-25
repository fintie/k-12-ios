import Foundation
import Combine

// MARK: - API Constants
struct APIConstants {
    static let baseURL = "https://stem.nextgenius.com.au/api" // Updated to correct domain
    static let apiKey = "YOUR_API_KEY" // Replace with actual API key
}

// MARK: - Network Error Types
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case httpError(Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode data"
        case .httpError(let statusCode):
            return "HTTP Error: \(statusCode)"
        case .unknown:
            return "Unknown error occurred"
        }
    }
}

// MARK: - Network Service
class NetworkService: ObservableObject {
    static let shared = NetworkService()
    
    private init() {}
    
    // Generic function to fetch data from API
    func fetchData<T: Codable>(endpoint: String, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: "\(APIConstants.baseURL)\(endpoint)") else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(APIConstants.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: responseType, decoder: JSONDecoder())
            .mapError { error in
                if let httpError = error as? DecodingError {
                    return NetworkError.decodingError
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    // Generic function to post data to API
    func postData<T: Codable, U: Codable>(endpoint: String, data: T, responseType: U.Type) -> AnyPublisher<U, NetworkError> {
        guard let url = URL(string: "\(APIConstants.baseURL)\(endpoint)") else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        guard let encodedData = try? JSONEncoder().encode(data) else {
            return Fail(error: NetworkError.decodingError)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(APIConstants.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encodedData
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: responseType, decoder: JSONDecoder())
            .mapError { _ in NetworkError.unknown }
            .eraseToAnyPublisher()
    }
}

// MARK: - API Endpoints
struct APIEndpoints {
    // User endpoints
    static let getUser = "/users/me"
    static let updateUser = "/users/me"
    
    // Course endpoints
    static let getCourses = "/courses"
    static let getCourse = "/courses/{id}"
    static let enrollCourse = "/courses/{id}/enroll"
    
    // Lesson endpoints
    static let getLessons = "/lessons"
    static let getLesson = "/lessons/{id}"
    static let completeLesson = "/lessons/{id}/complete"
    
    // Challenge endpoints
    static let getChallenges = "/challenges"
    static let submitChallenge = "/challenges/{id}/submit"
    
    // Community endpoints
    static let getPosts = "/posts"
    static let createPost = "/posts"
    static let likePost = "/posts/{id}/like"
}