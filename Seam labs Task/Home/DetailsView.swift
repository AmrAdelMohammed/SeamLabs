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
    @State private var ratingString: String = ""
    @State private var isRatingValid: Bool = true
    
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
                
                
                Text("Enter Rating (1-5)")
                    .font(.title2)
                    .padding()

                TextField("Rating", text: $ratingString)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding()

                Button("Check Rating") {
                    guard let rating = Int(ratingString) else {
                        isRatingValid = false
                        return
                    }
                    isRatingValid = (1...5).contains(rating)
                }
                .padding()
                .foregroundColor(.white)
                .background(isRatingValid ? Color.blue : Color.red)
                .cornerRadius(8)
                .padding(.bottom)
                
                if !isRatingValid {
                    Text("Please enter a valid rating (1-5)")
                        .foregroundColor(.red)
                        .padding(.bottom)
                }
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
