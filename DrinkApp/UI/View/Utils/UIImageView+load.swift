//
//  UIImageView+load.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 21.08.2022.
//

import Foundation
import UIKit

extension UIImageView {
    // FIXME: if we wanted to unit test views, that would be isolated in Data layer
    func load(from url: URL, cache: URLCache) {
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data,
           let image = UIImage(data: data) {
            set(image: image)
            return // Cached
        }

        // Load
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self,
                  let data = data,
                  let response = response,
                  self.isOkHttp(response),
                  let image = UIImage(data: data) else { return }

            let cachedData = CachedURLResponse(response: response,
                                               data: data)
            cache.storeCachedResponse(cachedData, for: request)
            self.set(image: image)
        }
        .resume()
    }
    
    private func isOkHttp(_ response: URLResponse) -> Bool {
        if let response = response as? HTTPURLResponse,
           (200...299).contains(response.statusCode) {
            return true
        }
        
        return false
    }
    
    private func set(image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.image = image
        }
    }
}
