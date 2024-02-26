//
//  HTTPClient.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Completion = Result<(Data, HTTPURLResponse), Error>
    
    /// The completion handler can be invoked in any thread.
    /// Client are responsible to dispatch to appropriate thread, if needed.
    @discardableResult
    func get(from url: URL, completion: @escaping (Completion) -> Void) -> HTTPClientTask
}
