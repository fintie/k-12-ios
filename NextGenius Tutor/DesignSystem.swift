import SwiftUI

// MARK: - Color Palette
extension Color {
    static let primary = Color(red: 0.2, green: 0.4, blue: 0.8)
    static let secondary = Color(red: 0.4, green: 0.6, blue: 0.9)
    static let accent = Color(red: 0.9, green: 0.3, blue: 0.3)
    static let background = Color(red: 0.95, green: 0.95, blue: 0.97)
    static let cardBackground = Color.white
    static let textPrimary = Color.black
    static let textSecondary = Color.gray
}

// MARK: - Typography
struct Typography {
    static let largeTitle = Font.system(size: 34, weight: .bold)
    static let title = Font.system(size: 28, weight: .semibold)
    static let headline = Font.system(size: 22, weight: .semibold)
    static let body = Font.system(size: 17, weight: .regular)
    static let caption = Font.system(size: 15, weight: .regular)
    static let footnote = Font.system(size: 13, weight: .regular)
}

// MARK: - Spacing
struct Spacing {
    static let extraSmall: CGFloat = 4
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let extraLarge: CGFloat = 32
}

// MARK: - Corner Radius
struct CornerRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
}

// MARK: - Custom Components
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.primary)
            .foregroundColor(.white)
            .cornerRadius(CornerRadius.medium)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.secondary)
            .foregroundColor(.white)
            .cornerRadius(CornerRadius.medium)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.large)
        .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}