import SwiftUI

struct LessonDetailView: View {
    @EnvironmentObject var userManager: UserManager
    let lesson: Lesson
    @State private var showContent = false
    @State private var showCompletion = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.large) {
                // Lesson Header
                VStack(alignment: .leading, spacing: Spacing.small) {
                    Text(lesson.title)
                        .font(Typography.largeTitle)
                        .fadeIn(delay: 0.1)
                        .accessibilityHeader(label: "Lesson title: \(lesson.title)")
                    
                    HStack {
                        Text("Type: \(lesson.type.rawValue.capitalized)")
                            .font(Typography.caption)
                            .padding(.horizontal, Spacing.small)
                            .padding(.vertical, 2)
                            .background(Color.secondary)
                            .foregroundColor(.white)
                            .cornerRadius(CornerRadius.small)
                        
                        Spacer()
                        
                        if userManager.isLessonCompleted(lessonId: lesson.id) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .fadeIn(delay: 0.2)
                                .accessibilityImage(label: AccessibilityHelper.lessonCompletedLabel, hint: AccessibilityHelper.lessonCompletedHint)
                        }
                    }
                }
                .fadeIn(delay: 0.1)
                
                // Lesson Content
                CardView {
                    Text(lesson.content)
                        .font(Typography.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(showContent ? 1.0 : 0.0)
                        .accessibilityText(label: "Lesson content")
                }
                .onAppear {
                    withAnimation(AnimationConstants.smooth.delay(0.3)) {
                        showContent = true
                    }
                }
                
                // Completion Status and Button
                if !userManager.isLessonCompleted(lessonId: lesson.id) {
                    Button(action: {
                        withAnimation(AnimationConstants.buttonPress) {
                            userManager.markLessonAsCompleted(lessonId: lesson.id)
                            showCompletion = true
                        }
                    }) {
                        HStack {
                            Text("Mark as Complete")
                                .fontWeight(.semibold)
                            Image(systemName: "checkmark")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .scaleUpOnTap()
                    .accessibilityButton(label: AccessibilityHelper.lessonCompleteButtonLabel, hint: AccessibilityHelper.lessonCompleteButtonHint)
                } else {
                    CardView {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Lesson Completed!")
                                .font(Typography.headline)
                                .foregroundColor(.green)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .fadeIn(delay: 0.4)
                    .accessibilityText(label: AccessibilityHelper.lessonCompletedLabel)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Lesson")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LessonDetailView(lesson: Lesson(id: UUID().uuidString, title: "Sample Lesson", content: "This is the content of a sample lesson. It can contain text, code examples, or even quiz questions.", type: .text, isCompleted: false))
            .environmentObject(UserManager())
    }
}


