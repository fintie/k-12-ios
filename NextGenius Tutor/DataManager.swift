import Foundation
import Combine

class DataManager: ObservableObject {
    static let shared = DataManager()
    private let coreDataManager = CoreDataManager.shared
    
    @Published var courses: [Course] = []
    @Published var challenges: [Challenge] = []
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        // Load cached data initially
        loadCachedData()
    }
    
    // Load cached data from Core Data
    func loadCachedData() {
        courses = coreDataManager.fetchCourses()
        // Posts and challenges would be loaded similarly if cached
    }
    
    // Fetch courses from API
    func fetchCourses() {
        isLoading = true
        errorMessage = nil
        
        NetworkService.shared.fetchData(endpoint: APIEndpoints.getCourses, responseType: [Course].self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] courses in
                    self?.courses = courses
                    // Cache courses in Core Data
                    self?.coreDataManager.saveCourses(courses)
                }
            )
            .store(in: &cancellables)
    }
    
    // Fetch challenges from API
    func fetchChallenges() {
        isLoading = true
        errorMessage = nil
        
        NetworkService.shared.fetchData(endpoint: APIEndpoints.getChallenges, responseType: [Challenge].self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] challenges in
                    self?.challenges = challenges
                }
            )
            .store(in: &cancellables)
    }
    
    // Fetch community posts from API
    func fetchPosts() {
        isLoading = true
        errorMessage = nil
        
        NetworkService.shared.fetchData(endpoint: APIEndpoints.getPosts, responseType: [Post].self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] posts in
                    self?.posts = posts
                }
            )
            .store(in: &cancellables)
    }
    
    // Submit challenge solution
    func submitChallengeSolution(challengeId: String, solution: Solution) {
        // Implementation would go here
    }
    
    // Create a new post
    func createPost(post: Post) {
        isLoading = true
        errorMessage = nil
        
        NetworkService.shared.postData(endpoint: APIEndpoints.createPost, data: post, responseType: Post.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] newPost in
                    self?.posts.insert(newPost, at: 0)
                }
            )
            .store(in: &cancellables)
    }
    
    // Like a post
    func likePost(postId: String) {
        // Implementation would go here
    }
}