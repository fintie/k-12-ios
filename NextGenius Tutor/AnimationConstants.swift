import SwiftUI

struct AnimationConstants {
    // Standard animations
    static let standard = Animation.easeInOut(duration: 0.3)
    static let spring = Animation.spring(response: 0.3, dampingFraction: 0.7)
    static let smooth = Animation.easeOut(duration: 0.5)
    
    // Specific animations
    static let buttonPress = Animation.easeInOut(duration: 0.1)
    static let cardAppear = Animation.easeOut(duration: 0.4)
    static let slideIn = Animation.easeOut(duration: 0.3)
    
    // Timing
    static let fastDuration: Double = 0.2
    static let mediumDuration: Double = 0.3
    static let slowDuration: Double = 0.5
}

// MARK: - View Extensions for Animations
extension View {
    /// Applies a fade-in animation
    func fadeIn(delay: Double = 0) -> some View {
        self
            .opacity(1)
            .animation(AnimationConstants.smooth.delay(delay), value: UUID())
    }
    
    /// Applies a slide-in animation from the bottom
    func slideInFromBottom(delay: Double = 0) -> some View {
        self
            .transition(.move(edge: .bottom))
            .animation(AnimationConstants.slideIn.delay(delay), value: UUID())
    }
    
    /// Applies a scale animation
    func scaleUpOnTap(scaleAmount: CGFloat = 0.95) -> some View {
        self
            .scaleEffect(scaleAmount)
            .animation(AnimationConstants.buttonPress, value: UUID())
    }
    
    /// Applies a bounce animation
    func bounceOnAppear() -> some View {
        self
            .scaleEffect(0.5)
            .onAppear {
                withAnimation(AnimationConstants.spring) {
                    // This will trigger the animation when the view appears
                }
            }
    }
}