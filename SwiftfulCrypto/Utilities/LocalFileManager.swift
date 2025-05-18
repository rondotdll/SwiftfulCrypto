//
//  LocalFileManager.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/17/25.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() { }
    
    func saveImage(object: UIImage, imageName: String, folderName: String) {
        
        // create foder
        createFolderSafe(folderName: folderName)
        
        guard
            let data = object.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let e {
            print("Error caching image: '\(e)'")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        
        return UIImage(contentsOfFile: url.path())
    }
    
    private func createFolderSafe(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName)
            else { return }
        
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let e {
                print("Error creating cache folder: '\(e)'")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
            else {return nil}
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName)
            else {return nil}
        
        return folderURL.appendingPathComponent("\(imageName).png")
    }
}
