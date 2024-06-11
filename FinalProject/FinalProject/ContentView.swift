import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("AR罗盘")
                .font(.largeTitle)
                .padding()
            
            ARView()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
