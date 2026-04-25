import SwiftUI

struct CourseListView: View {
    // Dummy data for now
    let courses: [Course] = [
        Course(id: UUID().uuidString, title: "Python Basics", description: "Learn the fundamentals of Python programming.", language: "Python", difficulty: "Beginner", imageUrl: nil, modules: []),
        Course(id: UUID().uuidString, title: "Web Development with HTML/CSS", description: "Build your first websites.", language: "HTML", difficulty: "Beginner", imageUrl: nil, modules: []),
        Course(id: UUID().uuidString, title: "Advanced JavaScript", description: "Dive deep into JavaScript concepts.", language: "JavaScript", difficulty: "Intermediate", imageUrl: nil, modules: []),
        Course(id: UUID().uuidString, title: "SQL for Data Analysis", description: "Master database queries.", language: "SQL", difficulty: "Intermediate", imageUrl: nil, modules: []),
    ]
    
    @State private var animatedIndices: Set<Int> = []

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.medium) {
                    Text("All Courses")
                        .font(Typography.largeTitle)
                        .padding(.horizontal)
                        .fadeIn(delay: 0.1)
                        .accessibilityHeader(label: "All Courses")
                    
                    ForEach(Array(courses.enumerated()), id: \.element.id) { index, course in
                        CourseCard(course: course, index: index, isAnimated: animatedIndices.contains(index))
                            .onAppear {
                                withAnimation(AnimationConstants.cardAppear.delay(Double(index) * 0.1)) {
                                    animatedIndices.insert(index)
                                }
                            }
                            .accessibilityElement(children: .combine)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Courses")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct CourseCard: View {
    let course: Course
    let index: Int
    let isAnimated: Bool
    
    var body: some View {
        NavigationLink(destination: CourseDetailView(course: course)) {
            CardView {
                VStack(alignment: .leading, spacing: Spacing.small) {
                    // Header with difficulty badge
                    HStack {
                        Text(course.title)
                            .font(Typography.headline)
                        
                        Spacer()
                        
                        Text(course.difficulty)
                            .font(Typography.caption)
                            .padding(.horizontal, Spacing.small)
                            .padding(.vertical, 2)
                            .background(Color.secondary)
                            .foregroundColor(.white)
                            .cornerRadius(CornerRadius.small)
                    }
                    
                    Text(course.description)
                        .font(Typography.body)
                        .foregroundColor(.textSecondary)
                        .lineLimit(2)
                    
                    HStack {
                        Text(course.language)
                            .font(Typography.caption)
                            .padding(.horizontal, Spacing.small)
                            .padding(.vertical, 2)
                            .background(Color.accent)
                            .foregroundColor(.white)
                            .cornerRadius(CornerRadius.small)
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .scaleEffect(isAnimated ? 1.0 : 0.9)
            .opacity(isAnimated ? 1.0 : 0.0)
        }
        .accessibilityLabel("\(course.title) course")
        .accessibilityHint("Tap to view course details")
        .accessibilityElement(children: .contain)
        .accessibilityAddTraits(.isButton)
    }
}

struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}


