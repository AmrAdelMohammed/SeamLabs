//
//  ViewModelTests.swift
//  Seam labs TaskTests
//
//  Created by Amr Adel on 08/09/2023.
//

import XCTest
import Combine
@testable import Seam_labs_Task

final class ViewModelTests: XCTestCase {

    private var sut: HomeVM!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        let gateway = HomeGatewayMock()
        gateway.shouldSuccess = true
        let coreDataManager = CoreDataStackManager(saveToDisk: false)
        let localDataSource = AppHomeLocalDataSource(dataBaseManager: coreDataManager)
        let dataSource = HomeDataSource(homeGateway: gateway,
                                        localDataSource: localDataSource)
        sut = HomeVM(homeDataSource: dataSource)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchData() {
        sut.viewDidAppear()
        let expectation = self.expectation(description: "Waiting Response")
        sut.$NewsArray.dropFirst().sink { data in
            XCTAssertFalse(data.isEmpty)
            expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
