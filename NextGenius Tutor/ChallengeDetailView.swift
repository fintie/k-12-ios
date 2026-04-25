import SwiftUI

struct ChallengeDetailView: View {
    let challenge: Challenge
    @State private var userCode: String = ""
    @State private var output: String = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(challenge.title)
                        .font(.largeTitle)
                        .padding(.bottom, 5)

                    Text(challenge.description)
                        .font(.body)
                        .padding(.bottom, 10)

                    Text("Language: \(challenge.language)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("Difficulty: \(challenge.difficulty)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)

                    Text("Your Code:")
                        .font(.headline)
                    TextEditor(text: $userCode)
                        .font(.footnote)
                        .fontDesign(.monospaced)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .frame(height: 200)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                        .padding(.bottom)

                    Button(action: {
                        runChallengeCode()
                    }) {
                        Text("Run & Submit")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom)

                    Text("Output:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(output)
                        .font(.footnote)
                        .fontDesign(.monospaced)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(5)
                }
                .padding()
            }
        }
        .navigationTitle("Challenge")
        .onAppear {
            userCode = challenge.starterCode
        }
    }

    func runChallengeCode() {
        // In a real app, this would send the userCode and challenge.id to a backend
        // for execution against test cases and update the output with the result.
        // For now, we'll just simulate a success/failure.
        let isSuccess = Bool.random()
        if isSuccess {
            output = "Tests Passed! Your solution is correct.\nPoints earned: 100"
        } else {
            output = "Tests Failed. Please check your code.\nError: Test case 1 failed."
        }
    }
}

struct ChallengeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeDetailView(challenge: Challenge(id: UUID().uuidString, title: "Sample Challenge", description: "Solve this sample coding challenge.", language: "Swift", starterCode: "func solve() {\n    // Write your code here\n}", testCases: [], difficulty: "Easy", solutions: []))
    }
}


