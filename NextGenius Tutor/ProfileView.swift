import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                    VStack(alignment: .leading) {
                        Text(userManager.currentUser.username)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(userManager.currentUser.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.bottom)

                Text("Bio:")
                    .font(.headline)
                Text(userManager.currentUser.bio ?? "No bio provided.")
                    .font(.body)

                Text("Points: \(userManager.currentUser.points)")
                    .font(.headline)

                Text("Completed Courses: \(userManager.currentUser.completedCourses.count)")
                    .font(.headline)

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserManager())
    }
}


