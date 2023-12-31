//
//  HomeVM.swift
//  Seam labs Task
//
//  Created by Amr Adel on 04/09/2023.
//

import SwiftUI

class HomeVM: ObservableObject{
    
    private let homeDataSource: HomeDataSourceProtocol
    @Published private(set) var NewsArray: [Article] = [Article]()
    
    
    init(homeDataSource: HomeDataSourceProtocol = HomeDataSource()) {
        self.homeDataSource = homeDataSource
        
    }
    
    func viewDidAppear(){
        Task{
            await getNewArticles()
        }
    }
    
    private func getNewArticles() async {
        let NewsArray = await homeDataSource.getNews() ?? []
        DispatchQueue.main.async {
            self.NewsArray = NewsArray
        }
    }
    
}
