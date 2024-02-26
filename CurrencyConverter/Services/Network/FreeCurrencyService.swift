//
//  FreeCurrencyService.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

final class FreeCurrencyService: CurrencyService {
    private let url: URL?
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case invalidURL
        case connectivity
        case invalidData
    }
    
    public typealias Completion = CurrencyService.Completion
    
    init(url: URL?, client: HTTPClient = URLSessionHTTPClient()) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Completion) -> Void) {
        guard let url = url else {
            completion(.failure(Error.invalidURL))
            return
        }
        
        client.get(from: url) { result  in
            switch result {
            case let .success((data, response)):
                completion(FreeCurrencyService.map(data, from: response))
            case .failure(_):
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Completion {
        do {
            let model = try CurrencyDataMapper.map(data, from: response)
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
}
