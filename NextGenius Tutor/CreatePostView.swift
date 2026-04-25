import SwiftUI

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var postContent: String = ""
    @State private var codeSnippet: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Post")) {
                    TextEditor(text: $postContent)
                        .frame(height: 150)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                }

                Section(header: Text("Code Snippet (Optional)")) {
                    TextEditor(text: $codeSnippet)
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                }
            }
            .navigationTitle("Create New Post")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Post") {
                // In a real app, this would send the post to a backend
                print("New Post: \(postContent)")
                if !codeSnippet.isEmpty {
                    print("Code Snippet: \(codeSnippet)")
                }
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}


