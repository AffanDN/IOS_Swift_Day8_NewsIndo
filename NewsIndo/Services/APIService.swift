//
//  APIService.swift
//  NewsIndo
//
//  Created by Macbook Pro on 23/04/24.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    
    // suapaya gabisa dibuat di file lain
    private init() {}
    
    // returnnya newsarticle
    func fetchNews() async throws -> [NewsArticle] {
        guard let url = URL(string: Constant.newsUrl) else {throw
            URLError(.badURL)}
        
        let news = try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseDecodable(of: News.self) { response in
                switch response.result {
                case .success(let newsResponse) :
                    continuation.resume(returning: newsResponse.data)
                case.failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        return news
    }
}
