//
//  ImagesLoader.swift
//  AlarTest
//
//  Created by Алексей Папин on 02.10.2020.
//

import UIKit
import Alamofire

class ImagesLoader {
    static let shared = ImagesLoader()
    
    private init() {}
    
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    private var requests: [UIImageView: DataRequest] = [:]
    private var cache: [URL: Result<UIImage, Error>] = [:]
    
    func download(url: URL, into imageView: UIImageView, with size: CGSize) {
        if let result = cache[url] {
            imageView.image = try? result.get()
            return
        }
        
        let request = networkService.getImage(url: url, completion: {
            [weak self] result in
            
            switch result {
            case let .success(image):
                let resized = image.scalePreservingAspectRatio(targetSize: size)
                self?.cache.updateValue(.success(resized), forKey: url)
                imageView.image = resized
                
            case let .failure(error):
                self?.cache.updateValue(.failure(error), forKey: url)
                imageView.image = nil
            }
        })
        requests.updateValue(request, forKey: imageView)
    }
    
    func cancelTask(for imageView: UIImageView) {
        imageView.image = nil
        guard let request = requests[imageView] else {
            return
        }
        request.cancel()
        requests.removeValue(forKey: imageView)
    }
}
