import SwiftUI

struct CodePlaygroundView: View {
    @State private var code: String = "print(\"Hello, World!\")"
    @State private var output: String = ""

    var body: some View {
        VStack {
            TextEditor(text: $code)
                .font(.footnote)
                .fontDesign(.monospaced)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(height: 200)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                .padding()

            Button(action: {
                runCode()
            }) {
                Text("Run Code")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom)

            ScrollView {
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

            Spacer()
        }
        .navigationTitle("Code Playground")
    }

    func runCode() {
        // In a real app, this would send the code to a backend for execution
        // and update the output with the result.
        // For now, we'll just simulate an output.
        output = "Simulating code execution...\n\nOutput for: \n\(code)\n\n(Actual execution requires a backend service or embedded interpreter)"
    }
}

struct CodePlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        CodePlaygroundView()
    }
}


