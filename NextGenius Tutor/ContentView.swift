import SwiftUI

struct ContentView: View {
    @StateObject var userManager = UserManager()

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            CourseListView()
                .tabItem {
                    Label("Courses", systemImage: "book.closed.fill")
                }

            CommunityFeedView()
                .tabItem {
                    Label("Community", systemImage: "person.3.fill")
                }

            CodePlaygroundView()
                .tabItem {
                    Label("Playground", systemImage: "play.fill")
                }

            ChallengeListView()
                .tabItem {
                    Label("Challenges", systemImage: "medal.fill")
                }

            LeaderboardView()
                .tabItem {
                    Label("Leaderboard", systemImage: "list.number")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .environmentObject(userManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


