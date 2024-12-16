//
//  NetworkManager.swift
//  ImageCatches
//
//  Created by Srikanth Kyatham on 12/9/24.
//
import Foundation


class NetworkManager {
    static let shared = NetworkManager()
        private init() {}
    func fetchImages(completion: @escaping (Result<[ImageItem], Error>) -> Void) {
        let urlString = ServerConstants.baseURL + ServerConstants.photosEndpoint
            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let images = try JSONDecoder().decode([ImageItem].self, from: data)
                    completion(.success(images))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
}
