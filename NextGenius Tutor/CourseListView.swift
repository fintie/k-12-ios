import SwiftUI

struct CourseListView: View {
    // Dummy data for now
    let courses: [Course] = [
        Course(id: UUID().uuidString, title: "Python Basics", description: "Learn the fundamentals of Python programming.", language: "Python", difficulty: "Beginner", imageUrl: nil, modules: []),
        Course(id: UUID().uuidString, title: "Web Development with HTML/CSS", description: "Build your first websites.", language: "HTML", difficulty: "Beginner", imageUrl: nil, modules: []),
        Course(id: UUID().uuidString, title: "Advanced JavaScript", description: "Dive deep into JavaScript concepts.", language: "JavaScript", difficulty: "Intermediate", imageUrl: nil, modules: []),
        Course(id: UUID().uuidString, title: "SQL for Data Analysis", description: "Master database queries.", language: "SQL", difficulty: "Intermediate", imageUrl: nil, modules: []),
    ]

    var body: some View {
        NavigationView {
            List(courses) {
                course in
                NavigationLink(destination: CourseDetailView(course: course)) {
                    VStack(alignment: .leading) {
                        Text(course.title)
                            .font(.headline)
                        Text(course.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Courses")
        }
    }
}

struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}


