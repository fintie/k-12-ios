import Foundation
import Combine

class UserManager: ObservableObject {
    @Published var currentUser: User
    private var cancellables = Set<AnyCancellable>()
    private let coreDataManager = CoreDataManager.shared

    init() {
        // Try to load user from Core Data first
        if let savedUser = coreDataManager.fetchUser() {
            self.currentUser = savedUser
        } else {
            // Initialize with a dummy user if none exists
            self.currentUser = User(
                id: UUID().uuidString,
                username: "TestUser",
                email: "test@example.com",
                profilePictureURL: nil,
                bio: "",
                completedCourses: [],
                achievements: [],
                points: 0,
                completedLessons: [:]
            )
            // Save the initial user
            coreDataManager.saveUser(currentUser)
        }
        
        // Load progress from Core Data
        let progress = coreDataManager.fetchProgress(for: currentUser.id)
        currentUser.completedLessons = progress
    }

    func markLessonAsCompleted(lessonId: String) {
        currentUser.completedLessons[lessonId] = true
        // Save to Core Data
        coreDataManager.saveProgress(userId: currentUser.id, lessonId: lessonId, completed: true)
        coreDataManager.saveUser(currentUser)
        
        // Update points
        currentUser.points += 10
        
        // Notify backend of completion
        updateProgressOnBackend(lessonId: lessonId, completed: true)
    }

    func isLessonCompleted(lessonId: String) -> Bool {
        return currentUser.completedLessons[lessonId] ?? false
    }
    
    func markCourseAsCompleted(courseId: String) {
        if !currentUser.completedCourses.contains(courseId) {
            currentUser.completedCourses.append(courseId)
            currentUser.points += 100
            
            // Save to Core Data
            coreDataManager.saveUser(currentUser)
            
            // Notify backend of completion
            updateCourseCompletionOnBackend(courseId: courseId)
        }
    }
    
    func getProgressForCourse(courseId: String) -> Double {
        // In a real implementation, this would calculate actual progress
        // For now, we'll return a mock value or check if course is completed
        return currentUser.completedCourses.contains(courseId) ? 1.0 : 0.0
    }
    
    func addPoints(_ points: Int) {
        currentUser.points += points
        // Save to Core Data
        coreDataManager.saveUser(currentUser)
    }
    
    func addAchievement(_ achievement: String) {
        if !currentUser.achievements.contains(achievement) {
            currentUser.achievements.append(achievement)
            // Save to Core Data
            coreDataManager.saveUser(currentUser)
        }
    }
    
    func updateUser(_ user: User) {
        currentUser = user
        // Save to Core Data
        coreDataManager.saveUser(currentUser)
    }
    
    // MARK: - Private Methods
    
    private func updateProgressOnBackend(lessonId: String, completed: Bool) {
        // In a real app, this would make an API call to update progress on the backend
        // Example:
        /*
        let endpoint = "/users/\(currentUser.id)/lessons/\(lessonId)"
        let data = ["completed": completed]
        
        NetworkService.shared.postData(endpoint: endpoint, data: data, responseType: [String: Bool].self)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Failed to update progress: \(error)")
                    }
                },
                receiveValue: { _ in
                    print("Progress updated successfully")
                }
            )
            .store(in: &cancellables)
         */
    }
    
    private func updateCourseCompletionOnBackend(courseId: String) {
        // In a real app, this would make an API call to mark course as completed
    }
}


