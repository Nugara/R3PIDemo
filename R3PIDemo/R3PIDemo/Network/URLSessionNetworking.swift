//
//  URLSessionNetworking.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

class URLSessionNetworking: Networking {
    
    let session: URLSession
    
    init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func httpGet(endpoint: String, success: @escaping (Data?) -> (), failure: @escaping (NetworkingError) -> ()) {
        
        guard let url = URL(string: endpoint) else {
            failure(.invalidEndpoint)
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                failure(.generic)
                return
            }
            success(data)
        }
        dataTask.resume()
    }
}
