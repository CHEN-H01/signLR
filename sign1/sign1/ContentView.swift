import SwiftUI

struct ContentView: View {
    @State private var showCamera = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("Open Camera") {
                    showCamera = true
                }
                .buttonStyle(CaringButtonStyle())
                .sheet(isPresented: $showCamera) {
                    CameraViewAdapter()
                }

                Button("Upload Video") {
                    // Add video upload logic here
                }
                .buttonStyle(CaringButtonStyle())
            }
            .padding()
            .background(Color(#colorLiteral(red: 0.95, green: 0.95, blue: 0.97, alpha: 1))) // 浅灰色背景
            .navigationTitle("Sath")
        }
    }
}

// 自定义的关爱主题按钮样式
struct CaringButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.blue.opacity(0.7) : Color.blue) // 浅蓝色按钮
            .foregroundColor(.white)
            .clipShape(Capsule()) // 圆角胶囊形状
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .font(.title)
            .shadow(radius: 10) // 轻微的阴影
    }
}
