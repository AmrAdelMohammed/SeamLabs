//
//  UsersGateway.swift
//  MLGtest
//
//  Created by Amr Adel on 06/07/2023.
//

import Foundation

protocol NewsGateway{
    func getNews() async -> Result<NewsModel,Error>
}

class AppNewsGateway: NewsGateway{
    
    private let apiManager : APIManager
    
    init(apiManager: APIManager = AppAPIManager()) {
        self.apiManager = apiManager
    }
    
    func getNews() async -> Result<NewsModel, Error> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
        
        let formattedDate = dateFormatter.string(from: yesterday)
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/everything?q=Egypt&from=\(formattedDate)&sortBy=publishedAt&apiKey=94091ccab84f4a4dbe254299bb1ed23a")!)
        let res: Result<NewsModel, any Error> = await apiManager.request(urlRequest)
        return res
    }
    
}

