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
    private let localDataSource: HomeLocalDataSource
    
    init(homeGateway: NewsGateway = AppNewsGateway(),
         localDataSource: HomeLocalDataSource = AppHomeLocalDataSource()) {
        self.homeGateway = homeGateway
        self.localDataSource = localDataSource
    }
    
    func getNews() async -> [Article]? {
        let res = await homeGateway.getNews()
        switch res{
        case .success(let data):
            let news = data.articles ?? []
            self.localDataSource.deleteAllArticles()
            self.localDataSource.saveArticles(news)
            return news
        case .failure(_):
            return  self.localDataSource.getNews()
        }
    }
}
