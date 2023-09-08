//
//  HomeGatewayMock.swift
//  Seam labs TaskTests
//
//  Created by Amr Adel on 08/09/2023.
//
@testable import Seam_labs_Task

class HomeGatewayMock: NewsGateway {

    var shouldSuccess = true

    func getNews() async -> Result<NewsModel, Error> {
        if shouldSuccess {
            return .success(NewsModel(articles: [Article(sourceID: "Vít Štěpánek", sourceNAme: "Ukrajinské obilí a další zemědělské produkty nově míří do světa přes Chorvatsko, když běžná vývozní trasa Černým mořem je po odstoupení Ruska od tzv. obilné dohody nejistá. Alternativní cestu potvrdila ukrajinská i chorvatská strana, zatím se zřejmě jedná o p…", author: "Ukrajina začala obilí vyvážet přes Chorvatsko, mimo nebezpečné Černé moře", title: "https://www.novinky.cz/clanek/zahranicni-ukrajina-zacala-obili-vyvazet-pres-chorvatsko-mimo-nebezpecne-cerne-more-40442962", description: "https://d15-a.sdn.cz/d_15/c_img_QR_3/SVRBFP/ukrajina-obili-vyvoz-chorvatsko.jpeg?fl=cro,0,94,1800,1012%7Cres,1200,,1%7Cwebp,75", url: "2023-09-07T13:44:45Z", urlToImage: "Z ukrajinských pístav v delt Dunaje stovky kilometr proti proudu veletoku do chorvatského Vukovaru a z nj po eleznici napí zemí do jadranského pístavu Rijeky. A pak u pímo a bezpen po moi k zákazníkm… [+1802 chars]", publishedAt: "a", content:"Biztoc.com")]))
        } else {
            return .failure(APIError.unknown)
        }
    }
    
}

