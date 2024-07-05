import SwiftUI


//
//enum Flavor: String, CaseIterable, Identifiable {
//    case chocolate, vanilla, strawberry
//    var id: Self { self }
//}
//
//
//
//
//
//struct TestView: View {
//    @State private var selectedFlavor: Flavor = .chocolate
//    var body: some View {
//        
//        Picker("Flavor",selection: $selectedFlavor,
//               content: {
//            HStack{
//                Text("chocolate")
//                Circle()
//                    .frame(width: 12,height: 12)
//                    .foregroundStyle(.blue)
//                    .background(.red)
//            }.tag(Flavor.chocolate)
//            HStack{
//                Text("vanilla")
//                Circle()
//                    .frame(width: 12,height: 12)
//                    .foregroundStyle(.blue)
//                    .background(.red)
//            }.tag(Flavor.vanilla)
//            HStack{
//                Text("Strawberry")
//                Circle()
//                    .frame(width: 12,height: 12)
//                    .foregroundStyle(.blue)
//                    .background(.red)
//            }.tag(Flavor.strawberry)
//           
//            
//        })
//        .pickerStyle(.menu)
//    }
//}
//#Preview {
//    TestView()
//}


//struct TestView: View {
//    @State private var selectedColor = 0
//    let colors = [Color.red, Color.green, Color.blue]
//    let colorNames = ["Красный", "Зеленый", "Синий"]
//
//    var body: some View {
//        Picker(selection: $selectedColor, label: Text("Выберите цвет")) {
//            ForEach(0..<colors.count) { index in
//                HStack {
//                    Circle()
//                        .fill(self.colors[index])
//                        .frame(width: 20, height: 20)
//                    Text(self.colorNames[index])
//                }.tag(index)
//            }
//        }
//        .pickerStyle(WheelPickerStyle()) // Вы можете выбрать другой стиль Picker
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}

//struct TestView: View {
//    @State private var selectedColor: Color = 0
//    let colors = [Color.red, Color.green, Color.blue,Color.clear]
//    let colorNames = ["Работа", "Хобби", "Учеба","Другое"]
//    
//    var body: some View {
////        VStack {
////            Picker(selection: $selectedColor, label: Text("Выберите цвет")) {
////                ForEach(0..<colors.count) { index in
////                    HStack {
////                        Circle()
////                            .fill(self.colors[index])
////                            .frame(width: 20, height: 20)
////                        Text(self.colorNames[index])
////                            .frame(width: 80)
////                    }.tag(index)
////                }
////            }
////            .pickerStyle(WheelPickerStyle()) // Используем другой стиль Picker
////            .padding()
////
////        }
//        
//        
//        
//    }
//}
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}
