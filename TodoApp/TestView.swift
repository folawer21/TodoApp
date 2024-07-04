import SwiftUI



import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationView {
            Text("(o_o)")
                .navigationTitle("Today").navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        NavigationLink(destination: ContentView()) {
                            Image(systemName: "person.crop.circle").font(.title)
                        }
                    }
                }
        }
    }
}
#Preview {
    TestView()
}

