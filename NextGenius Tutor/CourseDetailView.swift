import SwiftUI

struct CourseDetailView: View {
    let course: Course

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.large) {
                // Course Header
                VStack(alignment: .leading, spacing: Spacing.small) {
                    HStack {
                        Text(course.title)
                            .font(Typography.largeTitle)
                        
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
                .padding(.horizontal)
                
                // Modules Section
                VStack(alignment: .leading, spacing: Spacing.medium) {
                    Text("Modules")
                        .font(Typography.headline)
                        .padding(.horizontal)
                    
                    // Placeholder for modules - in a real app this would come from the course data
                    ForEach(0..<3) { index in
                        ModuleCard(title: "Module \(index + 1)", description: "Description for module \(index + 1)")
                    }
                }
                
                // Action Button
                Button(action: {
                    // Navigate to modules
                }) {
                    HStack {
                        Text("Start Learning")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ModuleCard: View {
    let title: String
    let description: String
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: Spacing.small) {
                Text(title)
                    .font(Typography.headline)
                
                Text(description)
                    .font(Typography.body)
                    .foregroundColor(.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CourseDetailView(course: Course(id: UUID().uuidString, title: "Python Basics", description: "Learn the fundamentals of Python programming.", language: "Python", difficulty: "Beginner", imageUrl: nil, modules: []))
        }
    }
}


