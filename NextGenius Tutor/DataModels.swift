import Foundation

// MARK: - User Model
struct User: Identifiable, Codable {
    let id: String
    let username: String
    let email: String
    var profilePictureURL: URL?
    var bio: String?
    var completedCourses: [String]
    var achievements: [String]
    var points: Int
    var completedLessons: [String: Bool] // Dictionary to track lesson completion: [lessonId: isCompleted]
}

// MARK: - Course Model
struct Course: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let language: String // e.g., "Python", "C++", "Java"
    let difficulty: String // e.g., "Beginner", "Intermediate", "Advanced"
    let imageUrl: URL?
    var modules: [Module]
}

// MARK: - Module Model
struct Module: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    var lessons: [Lesson]
}

// MARK: - Lesson Model
struct Lesson: Identifiable, Codable {
    let id: String
    let title: String
    let content: String // Markdown or HTML content
    let type: LessonType
    var isCompleted: Bool // This will be managed by the User's completedLessons dictionary
}

enum LessonType: String, Codable {
    case text
    case code
    case quiz
}

// MARK: - Challenge Model
struct Challenge: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let language: String
    let starterCode: String
    let testCases: [String] // JSON representation of test cases
    let difficulty: String
    var solutions: [Solution]
}

// MARK: - Solution Model
struct Solution: Identifiable, Codable {
    let id: String
    let challengeId: String
    let userId: String
    let code: String
    let submissionDate: Date
    var passedTests: Bool
    var pointsEarned: Int
}

// MARK: - Post Model (Community Feed)
struct Post: Identifiable, Codable {
    let id: String
    let userId: String
    let username: String
    let content: String
    let postDate: Date
    var likes: [String] // Array of user IDs who liked the post
    var comments: [Comment]
    var codeSnippet: String? // Optional code snippet
}

// MARK: - Comment Model
struct Comment: Identifiable, Codable {
    let id: String
    let postId: String
    let userId: String
    let username: String
    let content: String
    let commentDate: Date
}

// MARK: - LearningPath Model
struct LearningPath: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let courses: [String] // Array of course IDs
    let recommendedFor: String // e.g., "Web Development", "Data Science"
}


