//
//  BasketViewControllerTests.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 02/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import XCTest
@testable import R3PIDemo

class BasketViewControllerTests: XCTestCase {
    
    var viewController: BasketViewController!
    
    override func setUp() {
        super.setUp()
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasketViewController") as! BasketViewController
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func test_GivenTwoCurrencies_WhenViewDidLoad_PickerLoadedWithTwoRows() {
        
        // Given
        viewController.currencyListService = givenTwoCurrencies()
        
        // When
        viewController.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(viewController.picker.numberOfRows(inComponent: 0), 2)
    }
    
    func test_GivenTwoCartItems_WhenViewDidLoad_ThenTotalInUSD() {
        
        // Given
        viewController.currencyListService = givenTwoCurrencies()
        viewController.cartItems = givenTwoCartItems()
        
        // When
        viewController.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(viewController.total, 5.15)
    }
    
    func test_GivenTwoCurrencies_WhenUserChangeCurrency_ThenQuoteUpdated() {
        
        // Given
        viewController.currencyListService = givenTwoCurrencies()
        viewController.liveQuoteService = givenUSDEURLiveQuote()
        viewController.loadViewIfNeeded()
        
        // When
        viewController.pickerIndex = 0
        viewController.donePicker()
        
        // Then
        XCTAssertEqual(viewController.exchangeRate, 0.874604)
    }
}

// MARK: - utils
extension BasketViewControllerTests {
    
    fileprivate func givenUSDEURLiveQuote() -> LiveQuoteServicing {
        let liveQuoteMap: [String: AnyObject] = [
            "source": "USD" as AnyObject,
            "quotes": [
                "USDUSD": 1,
                "USDEUR": 0.874604
                ] as AnyObject
        ]
        let liveQuote = LiveQuote(map: liveQuoteMap)
        let liveQuoteService = LiveQuoteServiceStub()
        liveQuoteService.responseSuccess = true
        liveQuoteService.liveQuoteStub = liveQuote
        return liveQuoteService
    }
    
    fileprivate func givenTwoCurrencies() -> CurrencyListServicing {
        var currencies: [Currency] = []
        currencies.append(Currency(code: "EUR", label: "EURO"))
        currencies.append(Currency(code: "USD", label: "United States Dollar"))
        
        let currencyListService = CurrencyListServiceStub()
        currencyListService.responseSuccess = true
        currencyListService.currencies = currencies
        
        return currencyListService
    }
    
    func givenTwoCartItems() -> [CartItem] {
        let peas = Product(map: ["id" : "1", "name" : "Peas", "price" : 0.95, "unit" : "per bag", "image" : "icPeas"])
        let eggs = Product(map: ["id" : "2", "name" : "Eggs", "price" : 2.10, "unit" : "per dozen", "image" : "icEggs"])
        let peasItem = CartItem(product: peas, quantity: 1)
        let eggsItem = CartItem(product: eggs, quantity: 2)
        
        return [peasItem, eggsItem]
    }
}
