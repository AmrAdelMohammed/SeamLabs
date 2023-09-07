//
//  DetailsView.swift
//  Seam labs Task
//
//  Created by Amr Adel on 06/09/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    
    var article: Article
    
    init(article: Article = Article()) {
        self.article = article
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Text(article.title ?? "")
                    .font(.title).multilineTextAlignment(.center)
                    .padding()
                
                AnimatedImage(url: URL(string: article.urlToImage ?? ""))
                    .resizable()
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                VStack(alignment: .leading){
                    LabelView(text: "Auther: \(article.author ?? "")")
                    LabelView(text: "Published At: \(article.publishedAt ?? "")")
                    LabelView(text: article.description ?? "")
                    LabelView(text: article.content ?? "")
                    LabelView(text: "Source: \(article.source?.name ?? "")")
                }
                .padding()
            }
        }
    }
}

struct LabelView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.body)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .padding()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
