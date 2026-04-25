import SwiftUI

struct PostRowView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                VStack(alignment: .leading) {
                    Text(post.username)
                        .font(.headline)
                    Text(post.postDate, format: .relative(presentation: .named))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.bottom, 5)

            Text(post.content)
                .font(.body)
                .padding(.bottom, 5)

            if let codeSnippet = post.codeSnippet {
                Text("Code Snippet:")
                    .font(.subheadline)
                    .padding(.bottom, 2)
                Text(codeSnippet)
                    .font(.footnote)
                    .fontDesign(.monospaced)
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .padding(.bottom, 5)
            }

            HStack {
                Image(systemName: "hand.thumbsup.fill")
                    .foregroundColor(.blue)
                Text("\(post.likes.count)")
                Spacer()
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .foregroundColor(.green)
                Text("\(post.comments.count)")
            }
            .font(.caption)
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


