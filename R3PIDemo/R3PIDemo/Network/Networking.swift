//
//  Networking.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/7/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case generic
    case invalidEndpoint
}

protocol Networking {
    func httpGet(endpoint: String, success: @escaping (Data?) -> (), failure: @escaping (NetworkingError) -> ())
}
