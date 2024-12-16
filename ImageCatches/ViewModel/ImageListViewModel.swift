//
//  ImageListViewModel.swift
//  ImageCatches
//
//  Created by Srikanth Kyatham on 12/9/24.
//

class ImageListViewModel{
    private var networkManager: NetworkManager
    var images: [ImageItem] = []
    
    init(networkManager: NetworkManager){
        self.networkManager = networkManager
    }
    
    func fetchImages(completion: @escaping (Bool) -> Void) {
            networkManager.fetchImages { [weak self] result in
                switch result {
                case .success(let imageItems):
                    self?.images = imageItems
                    completion(true)
                case .failure(let error):
                    print("Failed to fetch images: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    
}
