//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/16/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage?
    
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    private let imageName: String
    
    private let folderName: String = "coin_images"
    private let fileManager: LocalFileManager = LocalFileManager.instance
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let cachedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = cachedImage
            print("Found & Loaded image for \(imageName) from cache directory.")
        } else {
            print("Attempting to download image for \(imageName)...")
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        
        guard let url = URL(string: String(self.coin.image.split(separator: "?")[0])) else { return }
        
        imageSubscription = NetworkingManager.downloadData(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard
                    let self = self,
                    let downloadedImage = returnedImage
                    else { return }

                self.image = downloadedImage
                self.imageSubscription?.cancel() // close thread after receiving data
                self.fileManager.saveImage(object: downloadedImage, imageName: self.imageName, folderName: self.folderName)
                
                print("Downloaded & Saved image for \(imageName) to cache directory.")
            })
            
    }
}
