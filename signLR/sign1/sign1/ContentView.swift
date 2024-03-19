import Foundation
import SwiftUI
import PhotosUI
import UniformTypeIdentifiers
import Alamofire
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
    @State private var showPhotoPicker = false

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                Button(action: { open_camera_action("Open Camera") }, label: { label1 })
                .buttonStyle(.roundedAndShadowPro)
                .sheet(isPresented: $showCamera) {
                    CameraViewAdapter()
                }
                
                Button(action: { showPhotoPicker = true }, label: {
                    Text("Upload Video")
                })
                .buttonStyle(.roundedAndShadowPro)
                .sheet(isPresented: $showPhotoPicker) {
                    PhotoPicker(selectionLimit: 1, filter: .videos) { results in
                        if let result = results.first {
                            handlePickedVideo(result)
                        }
                    }
                }
                
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


    func handlePickedVideo(_ result: PHPickerResult) {
        result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { url, error in
            guard let url = url, error == nil else { return }
            
            // Update UI if needed
            DispatchQueue.main.async {
                self.videoURL = url
                // Now you can upload the video to your server
                uploadVideoToServer(videoURL: url)
            }
        }
    }

    func uploadVideoToServer(videoURL: URL) {
        // Specify your server upload URL and parameters
        let uploadURL = "https://yourserver.com/upload"
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(videoURL, withName: "video", fileName: videoURL.lastPathComponent, mimeType: "video/mp4")
        }, to: uploadURL).response { response in
            switch response.result {
            case .success(let responseData):
                // Handle success
                print("Video uploaded successfully: \(String(describing: responseData))")
            case .failure(let error):
                // Handle error
                print("Error uploading video: \(error.localizedDescription)")
            }
        }
    }
}
    
let label1 = Label("Open Camera", systemImage: "camera.circle.fill")
let label2 = Label("Upload Video", systemImage: "square.and.arrow.up.circle.fill")





