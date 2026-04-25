import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showStats = false
    @State private var showContinueLearning = false
    @State private var showRecentActivity = false
    @State private var showChallenges = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.large) {
                    // Welcome Section
                    CardView {
                        VStack(alignment: .leading, spacing: Spacing.small) {
                            Text("Welcome Back, \(userManager.currentUser.username)!")
                                .font(Typography.headline)
                                .foregroundColor(.primary)
                                .accessibilityHeader(label: AccessibilityHelper.homeWelcomeLabel)
                                .accessibilityHint(AccessibilityHelper.homeWelcomeHint)
                            
                            Text("Ready to continue your learning journey?")
                                .font(Typography.body)
                                .foregroundColor(.textSecondary)
                                .accessibilityText(label: "Ready to continue your learning journey")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .fadeIn(delay: 0.1)
                    .accessibilityElement(children: .contain)
                    
                    // Stats Section
                    HStack(spacing: Spacing.medium) {
                        StatCard(
                            title: "Points",
                            value: "\(userManager.currentUser.points)",
                            accessibilityValue: AccessibilityHelper.pointsValue(userManager.currentUser.points)
                        )
                        StatCard(
                            title: "Courses",
                            value: "\(userManager.currentUser.completedCourses.count)",
                            accessibilityValue: AccessibilityHelper.coursesCompletedValue(userManager.currentUser.completedCourses.count)
                        )
                        StatCard(
                            title: "Streak",
                            value: "5 days",
                            accessibilityValue: "5 day streak"
                        )
                    }
                    .fadeIn(delay: 0.2)
                    
                    // Continue Learning Section
                    Text("Continue Learning")
                        .font(Typography.headline)
                        .padding(.horizontal)
                        .fadeIn(delay: 0.3)
                        .accessibilityHeader(label: "Continue Learning section")
                    
                    // Recent Activity Section
                    Text("Recent Activity")
                        .font(Typography.headline)
                        .padding(.horizontal)
                        .fadeIn(delay: 0.4)
                        .accessibilityHeader(label: "Recent Activity section")
                    
                    // Upcoming Challenges Section
                    Text("Upcoming Challenges")
                        .font(Typography.headline)
                        .padding(.horizontal)
                        .fadeIn(delay: 0.5)
                        .accessibilityHeader(label: "Upcoming Challenges section")
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                // Trigger animations when view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(AnimationConstants.cardAppear) {
                        showStats = true
                        showContinueLearning = true
                        showRecentActivity = true
                        showChallenges = true
                    }
                }
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let accessibilityValue: String
    
    var body: some View {
        CardView {
            VStack(spacing: Spacing.extraSmall) {
                Text(value)
                    .font(Typography.headline)
                    .foregroundColor(.primary)
                Text(title)
                    .font(Typography.caption)
                    .foregroundColor(.textSecondary)
            }
        }
        .scaleEffect(showing ? 1.0 : 0.8)
        .opacity(showing ? 1.0 : 0.0)
        .onAppear {
            withAnimation(AnimationConstants.spring.delay(0.1)) {
                showing = true
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title) statistic")
        .accessibilityValue(accessibilityValue)
        .accessibilityAddTraits(.isStaticText)
    }
    
    @State private var showing = false
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserManager())
    }
}


