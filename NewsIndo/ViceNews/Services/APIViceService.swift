//
//  APIViceService.swift
//  NewsIndo
//
//  Created by Macbook Pro on 23/04/24.
//

import Foundation

import Alamofire

class APIViceService {
    static let shared = APIViceService()
    
    // suapaya gabisa dibuat di file lain
    private init() {}
    
    // returnnya newsarticle
    func fetchViceNews() async throws -> [ViceArticle] {
        guard let urlViceService = URL(string: Constant.newViceUrl) else {throw
            URLError(.badURL)}
        
        let newsViceService = try await withCheckedThrowingContinuation { continuation in
            AF.request(urlViceService).responseDecodable(of: ViceModel.self) { response in
                switch response.result {
                case .success(let newsResponseVice) :
                    continuation.resume(returning: newsResponseVice.data)
                case.failure(let errorVice):
                    continuation.resume(throwing: errorVice)
                }
            }
        }
        return newsViceService
    }
}
