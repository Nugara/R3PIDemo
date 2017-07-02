//
//  ProductListViewControllerTests.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import XCTest
@testable import R3PIDemo

class ProductListViewControllerTests: XCTestCase {
    
    var controller: ProductListViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ProuctListViewController") as! ProductListViewController
    }
    
    override func tearDown() {
        controller = nil
        super.tearDown()
    }
    
    func test_WhenViewDidLoad_ControllerFetchesProductListAndCurrencyList() {
        let productListService = ProductListServiceStub()
        productListService.responseSuccess = false
        productListService.errorStub = .generic
        controller.productListService = productListService
        
        controller.loadViewIfNeeded()
        
        XCTAssertTrue(productListService.fetchCalled)
    }
    
    func test_WhenViewDidLoad_ThenCheckNumberOfRowsInTableView() {
        
        // When
        controller.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(controller.tableProductList.numberOfRows(inSection: 0), 4)
    }
    
    func test_GivenZeroItemInCart_WhenAddOnePeas_ThenPeasCellUpdated() {
        // Given
        controller.loadViewIfNeeded()
        
        // When
        controller.addButtonTapped(at: 0)
        
        let peasIndexPath = IndexPath(row: 0, section: 0)
        let peasCell = controller.tableProductList.cellForRow(at: peasIndexPath) as! ProductTableViewCell
        
        XCTAssertEqual(peasCell.labelQuantity.text, "1")
    }
    
    func test_GivenOneItemInCart_WhenRemoveOnePeas_ThenPeasCellUpdated() {
        // Given
        controller.loadViewIfNeeded()
        controller.addButtonTapped(at: 0)

        // When
        controller.removeButtonTapped(at: 0)
        
        let peasIndexPath = IndexPath(row: 0, section: 0)
        let peasCell = controller.tableProductList.cellForRow(at: peasIndexPath) as! ProductTableViewCell
        
        XCTAssertEqual(peasCell.labelQuantity.text, "0")
    }
}
