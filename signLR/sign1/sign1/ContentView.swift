import SwiftUI

struct ContentView: View {
    @State private var showCamera = false
    var body: some View {
        ZStack {
//            // 自定义背景
//            CustomBackground()
//                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Button("Open Camera") {
                    showCamera = true
                }
                .buttonStyle(CaringButtonStyle())
                .sheet(isPresented: $showCamera) {
                    CameraViewAdapter()
                }

                Button("Upload Video") {
                    // 添加上传视频的逻辑
                }
                .buttonStyle(CaringButtonStyle())
            }
        }
        // 使布局撑满屏幕
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        // 设置背景色
        .background(
            Image("back")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

// 自定义的关爱主题按钮样式
struct CaringButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width:200, height: 25, alignment: .center)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors:   [Color.blue.opacity(0.7), Color.blue]), startPoint: .top, endPoint: .bottom))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .font(.title)
            
    }
}

// 自定义背景视图
struct CustomBackground: View {
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            VStack {
                Spacer()
                // 底部的渐变条
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.925, green: 0.941, blue: 0.945, alpha: 1)), Color(#colorLiteral(red: 0.878, green: 0.925, blue: 0.941, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                    .frame(height: size.height * 0.1)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .background(
                // 主要的渐变背景
                RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.984, blue: 0.965, alpha: 1)), Color(#colorLiteral(red: 0.804, green: 0.882, blue: 0.941, alpha: 1))]), center: .center, startRadius: 2, endRadius: 650)
            )
        }
    }
}



