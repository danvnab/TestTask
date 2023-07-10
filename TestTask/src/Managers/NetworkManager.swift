//
//  NetworkManager.swift
//  TestTask
//
//  Created by Danil Velanskiy on 09.07.2023.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

class NetworkManager {
    
    private var cache: NSCache<NSURL, UIImage> = NSCache()
    private var dataCache = NSCache<NSURL, AnyObject>()
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Codable>(from url: String, queryItems: [URLQueryItem] = []) async throws -> T {
        guard var urlComponents = URLComponents(string: url) else {
            throw NetworkError.badURL
        }
        
        let apiKeyQuery = URLQueryItem(name: "api-key", value: "7AuSzW8X2FAyTKssLvn75E7GxdyecQLz")
        urlComponents.queryItems = [apiKeyQuery] + queryItems
        
        guard let finalURL = urlComponents.url else {
            throw NetworkError.badURL
        }
        
        if let cachedData = dataCache.object(forKey: finalURL as NSURL) as? T {
            return cachedData
        }
        
        let (data, response) = try await URLSession.shared.data(from: finalURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        dataCache.setObject(decodedData as AnyObject, forKey: finalURL as NSURL)
        
        return decodedData
    }
    
    
    func image(for url: NSURL) -> UIImage? {
        return cache.object(forKey: url)
    }
    
    func downloadImage(for url: NSURL?, completionHandler: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completionHandler(nil)
            return
        }
        if let cachedImage = image(for: url) {
            completionHandler(cachedImage)
        } else {
            let task = URLSession.shared.dataTask(with: url as URL) { [weak self] (data, response, error) in
                if let error = error {
                    print("Data task error: \(error.localizedDescription)")
                    completionHandler(nil)
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("Failed to create image from data.")
                    completionHandler(nil)
                    return
                }
                
                self?.cache.setObject(image, forKey: url)
                completionHandler(image)
            }
            task.resume()
        }
    }
}
