import SwiftUI

struct AccessibilityHelper {
    // MARK: - Accessibility Labels
    static let homeWelcomeLabel = "Welcome back message"
    static let courseCardLabel = "Course card"
    static let lessonCompleteButtonLabel = "Mark lesson as complete"
    static let lessonCompletedLabel = "Lesson completed"
    static let profileImageViewLabel = "User profile image"
    static let statCardLabel = "Statistics card"
    static let achievementBadgeLabel = "Achievement badge"
    
    // MARK: - Accessibility Hints
    static let homeWelcomeHint = "Shows personalized welcome message"
    static let courseCardHint = "Tap to view course details"
    static let lessonCompleteButtonHint = "Tap to mark this lesson as completed"
    static let lessonCompletedHint = "This lesson has been completed"
    static let profileImageViewHint = "User profile image"
    static let statCardHint = "Shows user statistics"
    static let achievementBadgeHint = "Achievement earned by user"
    
    // MARK: - Accessibility Values
    static func courseProgressValue(_ progress: Double) -> String {
        return "\(Int(progress * 100))% complete"
    }
    
    static func pointsValue(_ points: Int) -> String {
        return "\(points) points"
    }
    
    static func coursesCompletedValue(_ count: Int) -> String {
        return "\(count) courses completed"
    }
}

// MARK: - Accessibility Modifiers
extension View {
    /// Adds accessibility labels and traits for buttons
    func accessibilityButton(label: String, hint: String) -> some View {
        self
            .accessibilityLabel(label)
            .accessibilityHint(hint)
            .accessibilityAddTraits(.isButton)
    }
    
    /// Adds accessibility labels and traits for images
    func accessibilityImage(label: String, hint: String) -> some View {
        self
            .accessibilityLabel(label)
            .accessibilityHint(hint)
            .accessibilityAddTraits(.isImage)
    }
    
    /// Adds accessibility labels and traits for static text
    func accessibilityText(label: String) -> some View {
        self
            .accessibilityLabel(label)
            .accessibilityAddTraits(.isStaticText)
    }
    
    /// Adds accessibility labels and traits for headers
    func accessibilityHeader(label: String) -> some View {
        self
            .accessibilityLabel(label)
            .accessibilityAddTraits(.isHeader)
    }
    
    /// Adds accessibility value for dynamic content
    func accessibilityValue(_ value: String) -> some View {
        self
            .accessibilityValue(value)
    }
}