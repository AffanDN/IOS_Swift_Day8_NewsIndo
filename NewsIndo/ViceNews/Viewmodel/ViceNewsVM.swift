//
//  ViceNewsVM.swift
//  NewsIndo
//
//  Created by Macbook Pro on 23/04/24.
//

import Foundation

@MainActor
class ViceNewsVM: ObservableObject {
    @Published var articles = [ViceArticle]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchNews() async {
        isLoading = true
        errorMessage = nil
        
        do {
            articles = try await APIViceService.shared.fetchViceNews()
            isLoading = false
        } catch {
            errorMessage = "❤️‍🔥 \(error.localizedDescription), Failed to fetch News from API !! ❤️‍🔥"
            print(errorMessage ?? "N/A")
        }
    }
}
