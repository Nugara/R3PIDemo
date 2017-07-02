//
//  LiveQuoteParserStub.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation
@testable import R3PIDemo

class LiveQuoteParserStub: LiveQuoteParsing {
    var liveQuoteStub: LiveQuote?
    
    func parse(data: Data?) -> LiveQuote? {
        return liveQuoteStub
    }
}
