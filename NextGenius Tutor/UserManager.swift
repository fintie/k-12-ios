import Foundation

class UserManager: ObservableObject {
    @Published var currentUser: User

    init() {
        // For now, initialize with a dummy user. In a real app, this would load from persistent storage or a backend.
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
    }

    func markLessonAsCompleted(lessonId: String) {
        currentUser.completedLessons[lessonId] = true
        // In a real app, you would save this change to persistent storage or a backend.
        print("Lesson \(lessonId) marked as completed for user \(currentUser.username)")
    }

    func isLessonCompleted(lessonId: String) -> Bool {
        return currentUser.completedLessons[lessonId] ?? false
    }
}


