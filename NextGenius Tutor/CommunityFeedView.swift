import SwiftUI

struct CommunityFeedView: View {
    @State private var posts: [Post] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(posts) {
                    post in
                    PostRowView(post: post)
                }
            }
            .navigationTitle("Community Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CreatePostView()) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .onAppear(perform: loadPosts)
        }
    }

    func loadPosts() {
        // Dummy data for now. In a real app, this would fetch from a backend.
        posts = [
            Post(id: UUID().uuidString, userId: UUID().uuidString, username: "SwiftLearner", content: "Just finished my first Python project! Feeling great! #Python #Coding", postDate: Date().addingTimeInterval(-3600), likes: ["user1", "user2"], comments: [
                Comment(id: UUID().uuidString, postId: "", userId: UUID().uuidString, username: "CodeMaster", content: "Awesome! Keep up the good work!", commentDate: Date().addingTimeInterval(-3000))
            ]),
            Post(id: UUID().uuidString, userId: UUID().uuidString, username: "JavaDev", content: "Stuck on a Java concurrency issue. Any tips?", postDate: Date().addingTimeInterval(-7200), likes: [], comments: []),
            Post(id: UUID().uuidString, userId: UUID().uuidString, username: "WebWizard", content: "Check out my new responsive website!", postDate: Date().addingTimeInterval(-10800), likes: ["user3"], comments: [
                Comment(id: UUID().uuidString, postId: "", userId: UUID().uuidString, username: "DesignGuru", content: "Looks clean!", commentDate: Date().addingTimeInterval(-9000))
            ], codeSnippet: "```html\n<div class=\"container\">Hello World</div>\n```")
        ]
    }
}

struct CommunityFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityFeedView()
    }
}


