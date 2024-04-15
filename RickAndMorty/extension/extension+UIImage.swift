//
//  extension+UIImage.swift
//  RickAndMorty
//

import Foundation
import UIKit

extension UIImage {
    private static var imageCache = NSCache<AnyObject, AnyObject>()

    static func download(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: url.absoluteString)
        if let cachedImage = imageCache.object(forKey: cacheKey) as? UIImage {
            completion(cachedImage)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: cacheKey)
                completion(image)
            } else {
                completion(nil)
                print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}
