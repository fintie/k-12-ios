import SwiftUI

struct PostRowView: View {
    @EnvironmentObject var userManager: UserManager
    let post: Post

    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: Spacing.small) {
                // User info header
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.primary)
                    VStack(alignment: .leading) {
                        Text(post.username)
                            .font(Typography.headline)
                        Text(post.postDate, format: .relative(presentation: .named))
                            .font(Typography.caption)
                            .foregroundColor(.textSecondary)
                    }
                    Spacer()
                }
                
                // Post content
                Text(post.content)
                    .font(Typography.body)
                
                // Code snippet (if any)
                if let codeSnippet = post.codeSnippet {
                    VStack(alignment: .leading, spacing: Spacing.extraSmall) {
                        Text("Code Snippet:")
                            .font(Typography.caption)
                            .foregroundColor(.textSecondary)
                        
                        Text(codeSnippet)
                            .font(.system(.caption, design: .monospaced))
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(CornerRadius.small)
                    }
                }
                
                // Interaction buttons
                Divider()
                
                HStack(spacing: Spacing.large) {
                    Button(action: {
                        // Handle like action
                    }) {
                        HStack(spacing: Spacing.extraSmall) {
                            Image(systemName: post.likes.contains(userManager.currentUser.id) ? "hand.thumbsup.fill" : "hand.thumbsup")
                            Text("\(post.likes.count)")
                        }
                        .font(Typography.caption)
                        .foregroundColor(post.likes.contains(userManager.currentUser.id) ? .primary : .textSecondary)
                    }
                    
                    Button(action: {
                        // Handle comment action
                    }) {
                        HStack(spacing: Spacing.extraSmall) {
                            Image(systemName: "bubble.left.and.bubble.right")
                            Text("\(post.comments.count) Comments")
                        }
                        .font(Typography.caption)
                        .foregroundColor(.textSecondary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Handle share action
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(Typography.caption)
                            .foregroundColor(.textSecondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct PostRowView_Previews: PreviewProvider {
            .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(post: Post(id: UUID().uuidString, userId: UUID().uuidString, username: "TestUser", content: "This is a test post with some content.", postDate: Date(), likes: ["user1"], comments: [Comment(id: UUID().uuidString, postId: "", userId: UUID().uuidString, username: "Commenter", content: "Nice post!", commentDate: Date())], codeSnippet: "print(\"Hello, World!\")"))
            .previewLayout(.sizeThatFits)
    }
}


