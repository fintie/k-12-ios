import SwiftUI

struct LessonListView: View {
    let module: Module

    var body: some View {
        List(module.lessons) {
            lesson in
            NavigationLink(destination: LessonDetailView(lesson: lesson)) {
                VStack(alignment: .leading) {
                    Text(lesson.title)
                        .font(.headline)
                    Text(lesson.type.rawValue.capitalized)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Lessons")
    }
}

struct LessonListView_Previews: PreviewProvider {
    static var previews: some View {
        LessonListView(module: Module(id: UUID().uuidString, title: "Sample Module", description: "", lessons: [
            Lesson(id: UUID().uuidString, title: "Lesson 1: Hello World", content: "", type: .text, isCompleted: false),
            Lesson(id: UUID().uuidString, title: "Lesson 2: Variables", content: "", type: .code, isCompleted: false),
        ]))
    }
}


