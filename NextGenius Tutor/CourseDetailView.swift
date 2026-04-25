import SwiftUI

struct CourseDetailView: View {
    let course: Course

    var body: some View {
        VStack {
            Text(course.title)
                .font(.largeTitle)
                .padding()

            Text(course.description)
                .font(.title2)
                .padding()

            Text("Language: \(course.language)")
                .font(.body)
            Text("Difficulty: \(course.difficulty)")
                .font(.body)

            NavigationLink(destination: ModuleListView(course: course)) {
                Text("View Modules")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .navigationTitle("Course Details")
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(course: Course(id: UUID().uuidString, title: "Python Basics", description: "Learn the fundamentals of Python programming.", language: "Python", difficulty: "Beginner", imageUrl: nil, modules: []))
    }
}


