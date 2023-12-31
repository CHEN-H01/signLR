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
            .background(PatternedBackground()) // 使用图案背景
            .navigationTitle("Sath")
        }
    }
}

// 自定义的关爱主题按钮样式
struct CaringButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.blue.opacity(0.7) : Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .font(.title)
            .shadow(radius: 10)
    }
}

// 用于背景的图案
struct PatternedBackground: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let size = geometry.size
                let dotSize: CGFloat = 5
                let spacing: CGFloat = 20

                for x in stride(from: 0, through: size.width, by: spacing) {
                    for y in stride(from: 0, through: size.height, by: spacing) {
                        path.addEllipse(in: CGRect(x: x, y: y, width: dotSize, height: dotSize))
                    }
                }
            }
            .fill(Color.gray.opacity(0.2)) // 浅灰色的小圆点
        }
    }
}
