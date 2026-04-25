import SwiftUI

struct LeaderboardView: View {
    @State private var users: [User] = []

    var body: some View {
        NavigationView {
            List(users.sorted(by: { $0.points > $1.points })) {
                user in
                HStack {
                    Text("\(user.username)")
                    Spacer()
                    Text("\(user.points) points")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Leaderboard")
            .onAppear(perform: loadLeaderboard)
        }
    }

    func loadLeaderboard() {
        // Dummy data for now. In a real app, this would fetch from a backend.
        users = [
            User(id: UUID().uuidString, username: "CodeMaster", email: "", completedCourses: [], achievements: [], points: 1500, completedLessons: [:]),
            User(id: UUID().uuidString, username: "SwiftGuru", email: "", completedCourses: [], achievements: [], points: 1200, completedLessons: [:]),
            User(id: UUID().uuidString, username: "PythonPro", email: "", completedCourses: [], achievements: [], points: 1000, completedLessons: [:]),
            User(id: UUID().uuidString, username: "NewbieCoder", email: "", completedCourses: [], achievements: [], points: 500, completedLessons: [:]),
        ]
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}


