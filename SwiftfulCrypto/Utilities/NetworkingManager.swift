//
//  NetworkingManager.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/16/25.
//

import Foundation
import Combine

class NetworkingManager {
    
    private static let urlConfig = URLSessionConfiguration.default
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad Response from URL \"\(url)\""
            case .unknown:
                return "[⚠️]An unknown networking error occured"
            }
        }
    }
    
    static func downloadData(url: URL) -> AnyPublisher<Data, Error> {

        urlConfig.timeoutIntervalForRequest = 30 // (seconds)
        urlConfig.timeoutIntervalForResource = 60 // (seconds)
        
        return URLSession(configuration: urlConfig).dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap ({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let res = output.response as? HTTPURLResponse,
              res.statusCode >= 200 && res.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
