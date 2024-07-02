import SwiftUI



struct TestView: View{
    @State var colorHex: String? = nil
    @State private var selectedColor: Color = .blue
    @State private var brightness: Double = 1.0

    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .cyan, .brown, .indigo, .mint , .gray]
    
    var body: some View{
                Circle()
            .fill(selectedColor.opacity(brightness))
                    .brightness(1 - brightness)
                    .frame(width: 130, height: 130)
                    .padding()
    }
}



#Preview {
    TestView()
}

