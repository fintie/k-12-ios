import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to AI Tutor!")
                    .font(.largeTitle)
                    .padding()

                Spacer()

                Text("Start your learning journey today.")
                    .font(.title2)
                    .padding()

                Spacer()
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


