//
//  DataSourceTests.swift
//  Seam labs TaskTests
//
//  Created by Amr Adel on 08/09/2023.
//

import XCTest
import Combine
@testable import Seam_labs_Task

final class HomeDataSourceTests: XCTestCase {
    
    private var gateway: HomeGatewayMock!
    private var sut: HomeDataSource!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        self.gateway = HomeGatewayMock()
        let coreDataManager = CoreDataStackManager(saveToDisk: false)
        let localDataSource = AppHomeLocalDataSource(dataBaseManager: coreDataManager)
        sut = HomeDataSource(homeGateway: gateway,
                             localDataSource: localDataSource)
    }
    
    override func tearDownWithError() throws {
        gateway = nil
        sut = nil
    }
    
    func testNewsSave() async {
        self.gateway.shouldSuccess = true
        let data = await self.sut.getNews()
        self.gateway.shouldSuccess = false
        let dbData = await self.sut.getNews()
        XCTAssertEqual(data!.count, dbData!.count)
    }
    
}
