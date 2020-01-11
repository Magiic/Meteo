//
//  ImageDownloader.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

// MARK: - Wrapper Download Image
extension UIImageView {

    /// Download image directly from server.
    ///
    /// - Note:
    /// This is a lightweight wrapper to download image. Prefers use some libraries like KingFisher to handle cache and better performance.
    ///
    /// - Parameters:
    ///   - url: Image URL
    ///   - placeholderImage: Placeholder Image during loading or if error
    ///   - completion: Returned UIImage?
    func downloadImage(withURL url: URL, placeholderImage: UIImage? = nil, completion: ( (UIImage?) -> Void )?) {
        self.image = placeholderImage
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let imageData = data {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
                completion?(image)
                return
            } else {
                completion?(nil)
            }
        }.resume()
    }

}
