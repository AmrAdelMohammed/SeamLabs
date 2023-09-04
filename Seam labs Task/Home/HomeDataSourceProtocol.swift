//
//  HomeDataSourceProtocol.swift
//  Seam labs Task
//
//  Created by Amr Adel on 04/09/2023.
//

import Foundation

protocol HomeDataSourceProtocol {
    func getNews() async -> [Article]?
}

class HomeDataSource: HomeDataSourceProtocol {
   
    private let homeGateway: NewsGateway
    
    init(homeGateway: NewsGateway = AppNewsGateway()) {
        self.homeGateway = homeGateway
    }
    
    func getNews() async -> [Article]? {
        return []
    }
}
