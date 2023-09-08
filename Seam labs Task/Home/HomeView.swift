//
//  ContentView.swift
//  Seam labs Task
//
//  Created by Amr Adel on 04/09/2023.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeVM
    
    init(viewModel: HomeVM = HomeVM()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack{
            Color(.clear)
            NavigationStack{
    //            ScrollView{
                    List{
                        ForEach(viewModel.NewsArray){news in

                            NavigationLink(value: news){
                                NewsCardView(article: news).padding(.bottom, 8)
                            }

                        }
                        }.navigationDestination(for: Article.self) { item in
                            DetailsView(article: item)
                        
                    }
                }
        }.onAppear(perform: {
            self.viewModel.viewDidAppear()
        })
//        }
    }
  
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct NewsCardView: View {
    
    let article: Article
    
    var body: some View {
        VStack{
                        AnimatedImage(url: URL(string: article.urlToImage ?? ""))
                            .resizable()
                            .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }.frame(width: 200, height: 200)
                            .cornerRadius(10)
                            .padding(.trailing, 8)
            
            VStack(alignment: .leading){
                Text(article.title ?? "").font(.title).fontWeight(.medium)
                Text(article.author ?? "").font(.system(size: 12))
            }.padding()
            
            
            
        }
    }
}
