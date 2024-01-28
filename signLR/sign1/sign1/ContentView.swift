import Foundation
import SwiftUI

//struct ButtonView<V>: View where V: View {
//    let label: V
//    let action: () -> Void
//    init(label: V, action: @escaping () -> Void) {
//        self.label = label
//        self.action = action
//    }
//
//    var body: some View {
//        Button {
//            action()
//        } label: {
//            label
//                .foregroundColor(.white)
//                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundColor(.blue)
//                )
//                .compositingGroup()
//                .shadow(radius: 5, x: 0, y: 3)
//                .contentShape(Rectangle())
//        }
//        .buttonStyle(.plain)
//    }
//}

struct RoundedAndShadowProButtonStyle: ButtonStyle {
    @Environment(\.controlSize) var controlSize
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width:200, height: 40, alignment: .center)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .font(.title2)
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

//    func getPadding() -> EdgeInsets {
//        let unit: CGFloat = 4
//        switch controlSize {
//        case .regular:
//            return EdgeInsets(top: unit * 2, leading: unit * 4, bottom: unit * 2, trailing: unit * 4)
//        case .large:
//            return EdgeInsets(top: unit * 3, leading: unit * 5, bottom: unit * 3, trailing: unit * 5)
//        case .mini:
//            return EdgeInsets(top: unit / 2, leading: unit * 2, bottom: unit / 2, trailing: unit * 2)
//        case .small:
//            return EdgeInsets(top: unit, leading: unit * 3, bottom: unit, trailing: unit * 3)
//        @unknown default:
//            fatalError()
//        }
//    }

//    func getFontSize() -> Font {
//        switch controlSize {
//        case .regular:
//            return .body
//        case .large:
//            return .title3
//        case .small:
//            return .callout
//        case .mini:
//            return .caption2
//        @unknown default:
//            fatalError()
//        }
//    }
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
            VStack(spacing: 20) {
                
                Button(action: { open_camera_action("Open Camera") }, label: { label1 })
                .buttonStyle(.roundedAndShadowPro)
                .sheet(isPresented: $showCamera) {
                    CameraViewAdapter()
                }
                
                Button(action: { upload_action("Upload Video") }, label: { label2 })
                .buttonStyle(.roundedAndShadowPro)
                
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
    
    func open_camera_action(_ text: String) {
        showCamera = true
        print(text)
    }
    
    func upload_action(_ text: String) {
        print(text)
    }
}
    
let label1 = Label("Open Camera", systemImage: "camera.circle.fill")
let label2 = Label("Upload Video", systemImage: "square.and.arrow.up.circle.fill")





