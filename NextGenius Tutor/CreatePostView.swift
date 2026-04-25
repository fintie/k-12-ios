import SwiftUI

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userManager: UserManager
    @State private var postContent: String = ""
    @State private var codeSnippet: String = ""
    @StateObject private var dataManager = DataManager.shared

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Spacing.large) {
                    Text("Create New Post")
                        .font(Typography.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CardView {
                        VStack(alignment: .leading, spacing: Spacing.medium) {
                            // User info
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.primary)
                                VStack(alignment: .leading) {
                                    Text(userManager.currentUser.username)
                                        .font(Typography.headline)
                                    Text("Posting publicly")
                                        .font(Typography.caption)
                                        .foregroundColor(.textSecondary)
                                }
                                Spacer()
                            }
                            
                            // Post content editor
                            Text("What would you like to share?")
                                .font(Typography.body)
                                .foregroundColor(.textSecondary)
                            
                            TextEditor(text: $postContent)
                                .frame(height: 150)
                                .padding(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.small)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            
                            // Code snippet editor
                            Text("Code Snippet (Optional)")
                                .font(Typography.body)
                                .foregroundColor(.textSecondary)
                            
                            TextEditor(text: $codeSnippet)
                                .frame(height: 100)
                                .padding(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.small)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Post") {
                    createPost()
                }
                .disabled(postContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            )
        }
    }
    
    private func createPost() {
        // Create a new post object
        let newPost = Post(
            id: UUID().uuidString,
            userId: userManager.currentUser.id,
            username: userManager.currentUser.username,
            content: postContent,
            postDate: Date(),
            likes: [],
            comments: [],
            codeSnippet: codeSnippet.isEmpty ? nil : codeSnippet
        )
        
        // In a real app, this would send the post to a backend
        dataManager.createPost(post: newPost)
        
        // Dismiss the view
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
            .environmentObject(UserManager())
    }
}


