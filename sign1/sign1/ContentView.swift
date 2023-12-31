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
            .background(WavePatternBackground()) // 使用波浪线图案背景
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

// 波浪线图案背景
struct WavePatternBackground: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height

                // 创建波浪线
                path.move(to: CGPoint(x: 0, y: height * 0.5))
                for x in stride(from: 0, through: width, by: 40) {
                    let relativeX = x / width
                    let y = height * 0.5 + sin(relativeX * 2 * .pi) * 20
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(Color.blue.opacity(0.5), lineWidth: 2)
        }
    }
}
