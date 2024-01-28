import Foundation
import SwiftUI

struct ButtonView<V>: View where V: View {
    let label: V
    let action: () -> Void
    init(label: V, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            label
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                )
                .compositingGroup()
                .shadow(radius: 5, x: 0, y: 3)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct RoundedAndShadowProButtonStyle: ButtonStyle {
    @Environment(\.controlSize) var controlSize
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(getPadding())
            .font(getFontSize())
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(configuration.role == .destructive ? .red : .blue)
            )
            .compositingGroup()
            .overlay(
                VStack {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.5))
                            .blendMode(.hue)
                    }
                }
            )
            .shadow(radius: configuration.isPressed ? 0 : 5, x: 0, y: configuration.isPressed ? 0 : 3)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }

    func getPadding() -> EdgeInsets {
        let unit: CGFloat = 4
        switch controlSize {
        case .regular:
            return EdgeInsets(top: unit * 2, leading: unit * 4, bottom: unit * 2, trailing: unit * 4)
        case .large:
            return EdgeInsets(top: unit * 3, leading: unit * 5, bottom: unit * 3, trailing: unit * 5)
        case .mini:
            return EdgeInsets(top: unit / 2, leading: unit * 2, bottom: unit / 2, trailing: unit * 2)
        case .small:
            return EdgeInsets(top: unit, leading: unit * 3, bottom: unit, trailing: unit * 3)
        @unknown default:
            fatalError()
        }
    }

    func getFontSize() -> Font {
        switch controlSize {
        case .regular:
            return .body
        case .large:
            return .title3
        case .small:
            return .callout
        case .mini:
            return .caption2
        @unknown default:
            fatalError()
        }
    }
}

extension ButtonStyle where Self == RoundedAndShadowProButtonStyle {
    static var roundedAndShadowPro: RoundedAndShadowProButtonStyle {
        RoundedAndShadowProButtonStyle()
    }
}

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
                
                Button(action: { pressAction("rounded and shadow pro") }, label: { label })
                .buttonStyle(.roundedAndShadowPro)
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
    
    func pressAction(_ text: String) {
        //        alertMessage = Message(text: text)
        showCamera = true
        print(text)
    }
}
    
let label = Label("Press Me", systemImage: "digitalcrown.horizontal.press.fill")


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



