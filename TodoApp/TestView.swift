import SwiftUI



struct TestView: View{
    @State var colorHex: String? = nil
    @State private var selectedColor: Color = .blue
    @State private var brightness: Double = 1.0

    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .cyan, .brown, .indigo, .mint , .gray]
    
    var body: some View{
//        VStack(alignment: .leading){
//            Spacer()
//            HStack{
//                RoundedRectangle(cornerRadius: 15)
//                    .foregroundColor(selectedColor)
//                    .brightness(1 - brightness)
//                    .frame(width: 45,height: 45)
//                
//                Text("#of2341")
//                    .font(.system(size: 17))
//                    .fontWeight(.bold)
//                
//                Slider(value: $brightness, in: 0.0...1.0, step: 0.1)
//                
//            }
//            .padding()
//            
//            LazyVGrid(columns: Array(repeating: GridItem(), count: 4)) {
//                ForEach(colors, id: \.self) { color in
//                    Circle()
//                        .fill(color)
//                        .frame(width: 50, height: 50)
//                        .onTapGesture {
//                            selectedColor = color
//                        }
//                }
//            }
//            .padding()
//            HStack{
//                Spacer()
                Circle()
            .fill(selectedColor.opacity(brightness))
                    .brightness(1 - brightness)
                    .frame(width: 130, height: 130)
                    .padding()
//                    
//                Spacer()
//            }
//        }
    }
}



#Preview {
    TestView()
}

//import SwiftUI
//
//struct ColorPickerView: View {
//    @State private var selectedColor: Color = .white
//    @State private var brightness: Double = 1.0
//
//    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .cyan, .brown, .indigo, .mint , .gray]
//
//    var body: some View {
//        VStack {
//            LazyVGrid(columns: Array(repeating: GridItem(), count: 4)) {
//                ForEach(colors, id: \.self) { color in
//                    Circle()
//                        .fill(color)
//                        .frame(width: 50, height: 50)
//                        .onTapGesture {
//                            selectedColor = color
//                        }
//                }
//            }
//            .padding()
//
//            Circle()
//                .fill(selectedColor)
//                .brightness(1 - brightness)
//                .frame(width: 100, height: 100)
//                .padding()
//            Slider(value: $brightness, in: 0.0...1.0, step: 0.1)
//        }
//    }
//}

//struct ContentView1: View {
//    var body: some View {
//        ColorPickerView()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView1()
//    }
//}
