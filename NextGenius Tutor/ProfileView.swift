import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showHeader = false
    @State private var showStats = false
    @State private var showAchievements = false
    @State private var showBio = false
    @State private var showButtons = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: Spacing.large) {
                    // Profile Header
                    VStack(alignment: .center, spacing: Spacing.small) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.primary)
                            .scaleEffect(showHeader ? 1.0 : 0.5)
                            .opacity(showHeader ? 1.0 : 0.0)
                            .accessibilityImage(label: AccessibilityHelper.profileImageViewLabel, hint: AccessibilityHelper.profileImageViewHint)
                        
                        Text(userManager.currentUser.username)
                            .font(Typography.title)
                            .fontWeight(.bold)
                            .opacity(showHeader ? 1.0 : 0.0)
                            .accessibilityHeader(label: "User name: \(userManager.currentUser.username)")
                        
                        Text(userManager.currentUser.email)
                            .font(Typography.body)
                            .foregroundColor(.textSecondary)
                            .opacity(showHeader ? 1.0 : 0.0)
                            .accessibilityText(label: "Email: \(userManager.currentUser.email)")
                    }
                    .padding()
                    .onAppear {
                        withAnimation(AnimationConstants.spring.delay(0.1)) {
                            showHeader = true
                        }
                    }
                    .accessibilityElement(children: .contain)
                    
                    // Stats Cards
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
                    }
                    .padding(.horizontal)
                    .opacity(showStats ? 1.0 : 0.0)
                    .onAppear {
                        withAnimation(AnimationConstants.cardAppear.delay(0.2)) {
                            showStats = true
                        }
                    }
                    
                    // Achievements Section
                    VStack(alignment: .leading, spacing: Spacing.small) {
                        Text("Achievements")
                            .font(Typography.headline)
                            .padding(.horizontal)
                            .opacity(showAchievements ? 1.0 : 0.0)
                            .accessibilityHeader(label: "Achievements section")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: Spacing.medium) {
                                AchievementBadge(name: "First Course", icon: "book.fill")
                                AchievementBadge(name: "Quick Learner", icon: "brain.fill")
                                AchievementBadge(name: "Code Master", icon: "keyboard.fill")
                            }
                            .padding(.horizontal)
                        }
                    }
                    .opacity(showAchievements ? 1.0 : 0.0)
                    .onAppear {
                        withAnimation(AnimationConstants.cardAppear.delay(0.3)) {
                            showAchievements = true
                        }
                    }
                    
                    // Bio Section
                    CardView {
                        VStack(alignment: .leading, spacing: Spacing.small) {
                            Text("Bio")
                                .font(Typography.headline)
                                .accessibilityHeader(label: "User biography")
                            
                            Text(userManager.currentUser.bio ?? "No bio provided.")
                                .font(Typography.body)
                                .foregroundColor(.textSecondary)
                                .accessibilityText(label: userManager.currentUser.bio ?? "No bio provided")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    .opacity(showBio ? 1.0 : 0.0)
                    .onAppear {
                        withAnimation(AnimationConstants.cardAppear.delay(0.4)) {
                            showBio = true
                        }
                    }
                    .accessibilityElement(children: .contain)
                    
                    // Action Buttons
                    VStack(spacing: Spacing.medium) {
                        Button("Edit Profile") {
                            // Handle edit profile action
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .scaleUpOnTap()
                        .accessibilityButton(label: "Edit Profile", hint: "Tap to edit your profile information")
                        
                        Button("Settings") {
                            // Handle settings action
                        }
                        .buttonStyle(SecondaryButtonStyle())
                        .scaleUpOnTap()
                        .accessibilityButton(label: "Settings", hint: "Tap to access app settings")
                    }
                    .padding(.horizontal)
                    .opacity(showButtons ? 1.0 : 0.0)
                    .onAppear {
                        withAnimation(AnimationConstants.cardAppear.delay(0.5)) {
                            showButtons = true
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct AchievementBadge: View {
    let name: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color.primary)
                .clipShape(Circle())
                .bounceOnAppear()
                .accessibilityImage(label: "\(name) achievement", hint: AccessibilityHelper.achievementBadgeHint)
            
            Text(name)
                .font(Typography.caption)
                .multilineTextAlignment(.center)
                .accessibilityText(label: name)
        }
        .frame(width: 80)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(name) achievement badge")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserManager())
    }
}


