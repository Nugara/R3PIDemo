//
//  CurrencyLayerServiceTests.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import XCTest
@testable import R3PIDemo

class LiveQuoteServiceTests: XCTestCase {
    
    func test_GivenSourceAndDestinationCurrencies_WhenFetchLiveQuote_ThenEndpointCorrect() {
        
        // Given
        let networking = NetworkingStub()
        let parser = LiveQuoteParserStub()
        
        let service = LiveQuoteService(baseURL: "http://apilayer.net/api", accessKey: "291a947a295dd3517d6208901a75cd46", networking: networking, liveQuoteParsing: parser)
        
        // When
        service.fetch(from: "USD", to: "EUR", success: { liveQuote in
            // empty
        }) { error in
            // empty
        }
        
        let expectedEndpoint = "http://apilayer.net/api/live?access_key=291a947a295dd3517d6208901a75cd46&currencies=USD,EUR&format=1"
        
        XCTAssertEqual(networking.endpoint, expectedEndpoint)
    }
    
    func test_GivenNetworkingSuccess_WhenFetchLiveQuote_ThenSuccessWithQuoteGreaterThanZero() {
        var quoteFetched: LiveQuote?
        var errorFetched: LiveQuoteServiceError?
        
        // Given
        let networking = NetworkingStub()
        networking.errorStub = nil
        networking.dataStub = Data(base64Encoded: "eyJzdWNjZXNzIjp0cnVlLCJ0ZXJtcyI6Imh0dHBzOi8vY3VycmVuY3lsYXllci5jb20vdGVybXMiLCJwcml2YWN5IjoiaHR0cHM6Ly9jdXJyZW5jeWxheWVyLmNvbS9wcml2YWN5IiwidGltZXN0YW1wIjoxNDk4OTAzMzMyLCJzb3VyY2UiOiJVU0QiLCJxdW90ZXMiOnsiVVNEVVNEIjoxLCJVU0RFVVIiOjAuODc0NjA0fX0=")
        
        let parser = LiveQuoteParserStub()
        let liveQuoteMap: [String: AnyObject] = [
            "source": "USD" as AnyObject,
            "quotes": [
                "USDUSD": 1,
                "USDEUR": 0.874604
            ] as AnyObject
        ]
        parser.liveQuoteStub = LiveQuote(map: liveQuoteMap)
        
        let service = LiveQuoteService(baseURL: "fakeURL", accessKey: "fakeKey", networking: networking, liveQuoteParsing: parser)
        
        // When
        service.fetch(from: "USD", to: "EUR", success: { quote in
            quoteFetched = quote
        }) { error in
            errorFetched = error
        }
        
        // Then
        XCTAssertNil(errorFetched)
        XCTAssertNotNil(quoteFetched)
     
        XCTAssertEqual(quoteFetched!.source, "USD")
        XCTAssertEqual(quoteFetched!.quotes, ["USDUSD": 1, "USDEUR": 0.874604])
    }
    
    func test_GivenNetworkingError_WhenFetchLiveQuote_ThenError() {
        var quoteFetched: LiveQuote?
        var errorFetched: LiveQuoteServiceError?
        
        // Given
        let networking = NetworkingStub()
        networking.errorStub = .generic
        networking.dataStub = nil
        
        let parser = LiveQuoteParserStub()
        let liveQuoteMap: [String: AnyObject] = [
            "source": "USD" as AnyObject,
            "quotes": [
                "USDUSD": 1,
                "USDEUR": 0.874604
                ] as AnyObject
        ]
        parser.liveQuoteStub = LiveQuote(map: liveQuoteMap)
        
        let service = LiveQuoteService(baseURL: "fakeURL", accessKey: "fakeKey", networking: networking, liveQuoteParsing: parser)
        
        // When
        service.fetch(from: "USD", to: "EUR", success: { quote in
            quoteFetched = quote
        }) { error in
            errorFetched = error
        }
        
        // Then
        XCTAssertNotNil(errorFetched)
        XCTAssertNil(quoteFetched)
    }
}
