import SwiftUI

struct ModuleListView: View {
    @EnvironmentObject var userManager: UserManager
    let course: Course

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.medium) {
                ForEach(course.modules) { module in
                    ModuleCardView(module: module, courseId: course.id)
                }
            }
            .padding()
        }
        .navigationTitle("Modules")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ModuleCardView: View {
    @EnvironmentObject var userManager: UserManager
    let module: Module
    let courseId: String
    
    var body: some View {
        NavigationLink(destination: LessonListView(module: module)) {
            CardView {
                VStack(alignment: .leading, spacing: Spacing.small) {
                    HStack {
                        Text(module.title)
                            .font(Typography.headline)
                        
                        Spacer()
                        
                        // Progress indicator
                        if let progress = calculateProgress() {
                            ProgressRing(progress: progress)
                                .frame(width: 30, height: 30)
                        }
                    }
                    
                    Text(module.description)
                        .font(Typography.body)
                        .foregroundColor(.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private func calculateProgress() -> Double? {
        // In a real implementation, this would calculate actual progress
        // For now, we'll return nil to indicate no progress tracking
        return nil
    }
}

struct ProgressRing: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.gray.opacity(0.3),
                    lineWidth: 4
                )
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                .stroke(
                    progress >= 1.0 ? Color.green : Color.primary,
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

struct ModuleListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ModuleListView(course: Course(id: UUID().uuidString, title: "Sample Course", description: "", language: "", difficulty: "", imageUrl: nil, modules: [
                Module(id: UUID().uuidString, title: "Module 1: Introduction", description: "Introduction to the course topics", lessons: []),
                Module(id: UUID().uuidString, title: "Module 2: Basics", description: "Fundamental concepts", lessons: []),
            ]))
        }
        .environmentObject(UserManager())
    }
}


