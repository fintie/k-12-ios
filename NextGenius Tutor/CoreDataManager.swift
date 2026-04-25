import CoreData
import Foundation

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NextGeniusTutorModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {}
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - User Methods
    
    func saveUser(_ user: User) {
        let userEntity = UserEntity(context: context)
        userEntity.id = user.id
        userEntity.username = user.username
        userEntity.email = user.email
        userEntity.bio = user.bio
        userEntity.points = Int32(user.points)
        userEntity.completedCourses = user.completedCourses.joined(separator: ",")
        userEntity.achievements = user.achievements.joined(separator: ",")
        
        // Convert completedLessons dictionary to a string representation
        if let lessonsData = try? JSONSerialization.data(withJSONObject: user.completedLessons),
           let lessonsString = String(data: lessonsData, encoding: .utf8) {
            userEntity.completedLessons = lessonsString
        }
        
        saveContext()
    }
    
    func fetchUser() -> User? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            let userEntities = try context.fetch(request)
            if let userEntity = userEntities.first {
                var completedLessons: [String: Bool] = [:]
                if let lessonsString = userEntity.completedLessons,
                   let lessonsData = lessonsString.data(using: .utf8),
                   let lessonsDict = try? JSONSerialization.jsonObject(with: lessonsData) as? [String: Bool] {
                    completedLessons = lessonsDict
                }
                
                return User(
                    id: userEntity.id ?? "",
                    username: userEntity.username ?? "",
                    email: userEntity.email ?? "",
                    profilePictureURL: nil,
                    bio: userEntity.bio,
                    completedCourses: userEntity.completedCourses?.components(separatedBy: ",") ?? [],
                    achievements: userEntity.achievements?.components(separatedBy: ",") ?? [],
                    points: Int(userEntity.points),
                    completedLessons: completedLessons
                )
            }
        } catch {
            print("Failed to fetch user: \(error)")
        }
        
        return nil
    }
    
    // MARK: - Course Methods
    
    func saveCourses(_ courses: [Course]) {
        // Clear existing courses
        let fetchRequest: NSFetchRequest<CourseEntity> = CourseEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to clear courses: \(error)")
        }
        
        // Save new courses
        for course in courses {
            let courseEntity = CourseEntity(context: context)
            courseEntity.id = course.id
            courseEntity.title = course.title
            courseEntity.description = course.description
            courseEntity.language = course.language
            courseEntity.difficulty = course.difficulty
            
            // Save modules
            for module in course.modules {
                let moduleEntity = ModuleEntity(context: context)
                moduleEntity.id = module.id
                moduleEntity.title = module.title
                moduleEntity.description = module.description
                moduleEntity.course = courseEntity
                
                // Save lessons
                for lesson in module.lessons {
                    let lessonEntity = LessonEntity(context: context)
                    lessonEntity.id = lesson.id
                    lessonEntity.title = lesson.title
                    lessonEntity.content = lesson.content
                    lessonEntity.type = lesson.type.rawValue
                    lessonEntity.module = moduleEntity
                }
            }
        }
        
        saveContext()
    }
    
    func fetchCourses() -> [Course] {
        let request: NSFetchRequest<CourseEntity> = CourseEntity.fetchRequest()
        
        do {
            let courseEntities = try context.fetch(request)
            var courses: [Course] = []
            
            for courseEntity in courseEntities {
                var modules: [Module] = []
                
                // Fetch modules for this course
                if let moduleEntities = courseEntity.modules {
                    for case let moduleEntity as ModuleEntity in moduleEntities {
                        var lessons: [Lesson] = []
                        
                        // Fetch lessons for this module
                        if let lessonEntities = moduleEntity.lessons {
                            for case let lessonEntity as LessonEntity in lessonEntities {
                                lessons.append(Lesson(
                                    id: lessonEntity.id ?? "",
                                    title: lessonEntity.title ?? "",
                                    content: lessonEntity.content ?? "",
                                    type: LessonType(rawValue: lessonEntity.type ?? "text") ?? .text,
                                    isCompleted: false
                                ))
                            }
                        }
                        
                        modules.append(Module(
                            id: moduleEntity.id ?? "",
                            title: moduleEntity.title ?? "",
                            description: moduleEntity.description ?? "",
                            lessons: lessons
                        ))
                    }
                }
                
                courses.append(Course(
                    id: courseEntity.id ?? "",
                    title: courseEntity.title ?? "",
                    description: courseEntity.description ?? "",
                    language: courseEntity.language ?? "",
                    difficulty: courseEntity.difficulty ?? "",
                    imageUrl: nil,
                    modules: modules
                ))
            }
            
            return courses
        } catch {
            print("Failed to fetch courses: \(error)")
            return []
        }
    }
    
    // MARK: - Progress Methods
    
    func saveProgress(userId: String, lessonId: String, completed: Bool) {
        let progressEntity = ProgressEntity(context: context)
        progressEntity.userId = userId
        progressEntity.lessonId = lessonId
        progressEntity.completed = completed
        progressEntity.date = Date()
        
        saveContext()
    }
    
    func fetchProgress(for userId: String) -> [String: Bool] {
        let request: NSFetchRequest<ProgressEntity> = ProgressEntity.fetchRequest()
        request.predicate = NSPredicate(format: "userId == %@", userId)
        
        do {
            let progressEntities = try context.fetch(request)
            var progress: [String: Bool] = [:]
            
            for progressEntity in progressEntities {
                if let lessonId = progressEntity.lessonId {
                    progress[lessonId] = progressEntity.completed
                }
            }
            
            return progress
        } catch {
            print("Failed to fetch progress: \(error)")
            return [:]
        }
    }
}