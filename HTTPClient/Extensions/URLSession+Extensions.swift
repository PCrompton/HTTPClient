//
//  URLSession+Extensions.swift
//  HTTPClient
//
//  Created by Paul Crompton on 8/18/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocol {
    public func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {

        return dataTask(with: request.url!, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}
