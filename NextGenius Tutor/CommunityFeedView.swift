import SwiftUI

struct CommunityFeedView: View {
    @StateObject private var dataManager = DataManager.shared
    @EnvironmentObject var userManager: UserManager
    @State private var showingCreatePost = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Spacing.medium) {
                    ForEach(dataManager.posts) { post in
                        PostRowView(post: post)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Community Feed")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingCreatePost = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingCreatePost) {
                CreatePostView()
            }
            .onAppear(perform: loadData)
        }
    }

    func loadData() {
        // In a real app, this would fetch from a backend
        dataManager.fetchPosts()
    }
}

struct CommunityFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityFeedView()
            .environmentObject(UserManager())
    }
}


