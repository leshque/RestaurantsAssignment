//
//  RestaurantListPresenterTests.swift
//  RestorauntsAppTests
//
//  Created by Aliaksei Prokharau on 23.05.22.
//

import Foundation
@testable import RestorauntsApp
import XCTest

class RestaurantListPresenterTests: XCTestCase {
    
    var presenter: RestaurantListPresenter!
    var mockRestaurantListInteractor: MockRestaurantListInteractor!
    var mockRestaurantListView: MockRestaurantListView!
    var mockViewModelMapper: MockRestaurantListViewModelMapper!
    
    override func setUp() {
        mockRestaurantListInteractor = MockRestaurantListInteractor()
        mockRestaurantListView = MockRestaurantListView()
        mockViewModelMapper = MockRestaurantListViewModelMapper()
        presenter = RestaurantListPresenter(
            interactor: mockRestaurantListInteractor,
            viewModelMapper: mockViewModelMapper
        )
        presenter.view = mockRestaurantListView
    }
    
    func test_whenViewDidLoadIsCalled_thenLoadDataIsCalledWithExpectedParamenters() {
        let expectation = self.expectation(description: "interactor.loadData is called")
        mockRestaurantListInteractor.mockGetSortOption = { .alphabetic }
        mockRestaurantListInteractor.mockLoadData = { query, sortSettings, completion in
            XCTAssertEqual("", query)
            XCTAssertEqual(sortSettings.sortOrder, .ascending)
            expectation.fulfill()
        }
        
        presenter.viewDidLoad()
        waitForExpectations(timeout: 0.5, handler: nil)
    }

    func test_whenSortSelectionTapped_thenSortSelectorPresented() {
        let expectation = self.expectation(description: "view.presentSortSelector is called")
        mockRestaurantListView.mockPresentSortSelector = { _, _, _ in
            expectation.fulfill()
        }
        presenter.onSortSelectTapped()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
}
