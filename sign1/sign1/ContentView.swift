import SwiftUI

struct ContentView: View {
    @State private var showCamera = false

    var body: some View {
        NavigationView {
            VStack {
                Button("Open Camera") {
                    showCamera = true
                }
                .sheet(isPresented: $showCamera) {
                    CameraViewAdapter()
                }

                Button("Upload Video") {
                    // 这里添加上传视频的逻辑
                }
            }
        }
    }
}
