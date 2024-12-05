//
//  ImageCache.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import UIKit

actor ImageCache {
    static let shared = ImageCache()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        // Setup a directory within the caches directory
        if let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            cacheDirectory = cachesDirectory.appendingPathComponent("ImageCache")
            
            // Create the directory if it doesn't exist
            if !fileManager.fileExists(atPath: cacheDirectory.path) {
                try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
            }
        } else {
            fatalError("Failed to locate caches directory")
        }
    }
    
    /// Saves the image to disk with a specified key
    func set(image: UIImage, key: String) {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return }
        let fileURL = cacheDirectory.appendingPathComponent(key.toValidFileName())
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("Failed to save image to disk: \(error.localizedDescription)")
        }
    }
    
    /// Retrieves the image from disk with a specified key
    func get(key: String) async -> UIImage? {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .background).async { [weak self] in
                let fileURL = self?.cacheDirectory.appendingPathComponent(key.toValidFileName())
                guard let file = fileURL,
                      let data = try? Data(contentsOf: file),
                      let image = UIImage(data: data) else {
                    continuation.resume(returning: nil)
                    return
                }
                continuation.resume(returning: image)
            }
        }
    }
}

private extension String {
    /// Converts string to a valid file name by removing or replacing invalid characters
    func toValidFileName() -> String {
        return self.replacingOccurrences(of: "[^a-zA-Z0-9_]", with: "-", options: .regularExpression)
    }
}

