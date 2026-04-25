import SwiftUI

struct ModuleListView: View {
    let course: Course

    var body: some View {
        List(course.modules) {
            module in
            NavigationLink(destination: LessonListView(module: module)) {
                VStack(alignment: .leading) {
                    Text(module.title)
                        .font(.headline)
                    Text(module.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Modules")
    }
}

struct ModuleListView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListView(course: Course(id: UUID().uuidString, title: "Sample Course", description: "", language: "", difficulty: "", imageUrl: nil, modules: [
            Module(id: UUID().uuidString, title: "Module 1: Introduction", description: "", lessons: []),
            Module(id: UUID().uuidString, title: "Module 2: Basics", description: "", lessons: []),
        ]))
    }
}


