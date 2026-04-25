import SwiftUI

struct ChallengeListView: View {
    @State private var challenges: [Challenge] = []

    var body: some View {
        NavigationView {
            List(challenges) {
                challenge in
                NavigationLink(destination: ChallengeDetailView(challenge: challenge)) {
                    VStack(alignment: .leading) {
                        Text(challenge.title)
                            .font(.headline)
                        Text(challenge.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Coding Challenges")
            .onAppear(perform: loadChallenges)
        }
    }

    func loadChallenges() {
        // Dummy data for now. In a real app, this would fetch from a backend.
        challenges = [
            Challenge(id: UUID().uuidString, title: "FizzBuzz", description: "Write a program that prints numbers from 1 to 100. For multiples of three print \"Fizz\" instead of the number and for the multiples of five print \"Buzz\". For numbers which are multiples of both three and five print \"FizzBuzz\".", language: "Python", starterCode: "", testCases: [], difficulty: "Easy", solutions: []),
            Challenge(id: UUID().uuidString, title: "Palindrome Checker", description: "Write a function that checks if a given string is a palindrome.", language: "Python", starterCode: "", testCases: [], difficulty: "Medium", solutions: []),
            Challenge(id: UUID().uuidString, title: "Merge Sort", description: "Implement the Merge Sort algorithm.", language: "Java", starterCode: "", testCases: [], difficulty: "Hard", solutions: []),
        ]
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}


