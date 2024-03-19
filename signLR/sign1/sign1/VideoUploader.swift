import Foundation

class VideoUploader {
    func uploadVideo(_ videoURL: URL, completion: @escaping (String) -> Void) {
        // 1. 创建请求的 URL
    guard let uploadURL = URL(string: "https://yourserver.com/upload") else {
        completion("Invalid upload URL")
        return
    }

    // 2. 创建 URLRequest
    var request = URLRequest(url: uploadURL)
    request.httpMethod = "POST"

    // 3. 准备上传的数据
    let videoData = try? Data(contentsOf: videoURL)

    // 4. 使用 URLSession 上传数据
    let task = URLSession.shared.uploadTask(with: request, from: videoData) { data, response, error in
        // 处理响应和错误
        guard let data = data, error == nil else {
            completion("Upload failed: \(error?.localizedDescription ?? "Unknown error")")
            return
        }

        // 解析响应数据
        if let responseString = String(data: data, encoding: .utf8) {
            completion(responseString)
        } else {
            completion("Failed to decode response")
        }
    }

    // 5. 开始上传任务
    task.resume()
    }
}
