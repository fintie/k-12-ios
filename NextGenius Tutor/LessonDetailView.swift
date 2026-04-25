import SwiftUI

struct LessonDetailView: View {
    @EnvironmentObject var userManager: UserManager
    let lesson: Lesson

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(lesson.title)
                    .font(.largeTitle)
                    .padding(.bottom, 5)

                Text("Type: \(lesson.type.rawValue.capitalized)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)

                Text(lesson.content)
                    .font(.body)

                Spacer()

                if !userManager.isLessonCompleted(lessonId: lesson.id) {
                    Button(action: {
                        userManager.markLessonAsCompleted(lessonId: lesson.id)
                    }) {
                        Text("Mark as Complete")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                } else {
                    Text("Lesson Completed!")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.top)
                }
            }
            .padding()
        }
        .navigationTitle("Lesson")
    }
}

struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LessonDetailView(lesson: Lesson(id: UUID().uuidString, title: "Sample Lesson", content: "This is the content of a sample lesson. It can contain text, code examples, or even quiz questions.", type: .text, isCompleted: false))
            .environmentObject(UserManager())
    }
}


