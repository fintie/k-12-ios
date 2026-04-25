import SwiftUI

struct ContentView: View {
    @StateObject var userManager = UserManager()
    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            CourseListView()
                .tabItem {
                    Label("Courses", systemImage: "book.closed.fill")
                }
                .tag(1)

            CommunityFeedView()
                .tabItem {
                    Label("Community", systemImage: "person.3.fill")
                }
                .tag(2)

            CodePlaygroundView()
                .tabItem {
                    Label("Playground", systemImage: "play.fill")
                }
                .tag(3)

            ChallengeListView()
                .tabItem {
                    Label("Challenges", systemImage: "medal.fill")
                }
                .tag(4)

            LeaderboardView()
                .tabItem {
                    Label("Leaderboard", systemImage: "list.number")
                }
                .tag(5)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(6)
        }
        .environmentObject(userManager)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


