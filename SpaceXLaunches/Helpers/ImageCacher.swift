//
//  ImageCacher.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 22.06.2022.
//

import UIKit

struct ImageCacher {
    internal static var caches: [String: UIImage] = [:]
    
    static func clear() {
        caches.removeAll()
    }
}

extension UIImageView {
    func load(from urlString: String, placeholder: String) {
        if let cachedImage = ImageCacher.caches[urlString] {
            image = cachedImage
        } else if let url = URL(string: urlString) {
            image = UIImage(named: placeholder) ?? UIImage(systemName: placeholder)
            let session = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                DispatchQueue.main.async { [weak self] in
                    guard let data = data,
                          let downloadedImage = UIImage(data: data) else { return }
                    self?.image = downloadedImage
                    ImageCacher.caches[urlString] = downloadedImage
                }
            }
            session.resume()
        } else {
            image = UIImage(named: placeholder) ?? UIImage(systemName: placeholder)
        }
    }
}
