//
//  ViceNewsView.swift
//  NewsIndo
//
//  Created by Macbook Pro on 23/04/24.
//

import SwiftUI
import SafariServices

struct ViceNewsView: View {
    @State private var searchViceNews: String = ""
    @State private var isRedacted: Bool = true
    @StateObject private var viceNewsVM = ViceNewsVM()
    
    var viceSearchResults: [ViceArticle] {
        // guard : merupakan implementasi if doang
        guard !searchViceNews.isEmpty else {
            return viceNewsVM.articles
        }
        // bisa menggunakan $0 karena
        // $0 === emoji in emoji
        return viceNewsVM.articles.filter { vice in
            vice.title.lowercased().contains(searchViceNews.lowercased())
        }
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(viceSearchResults) {
                    articleVice in
                    HStack (spacing: 16){
                        AsyncImage(url: URL(string: articleVice.image)) { image in
                            image.resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(width: 100, height: 100)
                                .scaledToFit()
                        } placeholder: {
                            ZStack {
                                Color.brown
                                WaitingView()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                        }
                        VStack (alignment: .leading, spacing: 8) {
                            Text(articleVice.title)
                                .font(.headline)
                                .lineLimit(2)
                            Text(articleVice.creator)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            HStack (alignment: .bottom) {
                                Text(articleVice.isoDate.relativeToCurrentDate())
                                    .font(.caption)
                                Button {
                                    let vc = SFSafariViewController(url: URL(string: articleVice.link)!)
                                    UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                                } label: {
                                    Text("| Selengkapnya")
                                        .font(.caption)
                                        .foregroundStyle(.link)
                                }
                        }
                        }
                    }
                }
            }
            .navigationTitle(Constant.viceTitle)
            .listStyle(.plain)
            .task {
                await viceNewsVM.fetchNews()
            }
            .refreshable {
                await viceNewsVM.fetchNews()
//                isRedacted = true
//                let newViceNews = viceNewsVM.articles.randomElement()
//                viceNewsVM.articles.insert(newViceNews!, at: 0)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    isRedacted = false
//                }
            }
            .overlay {
//                viceNewsVM.isLoading ? ProgressView() : nil
                if viceSearchResults.isEmpty && viceNewsVM.isLoading{
                    WaitingView()
        
                }
                if viceSearchResults.isEmpty && !viceNewsVM.isLoading {
                    ContentUnavailableView.search(text: searchViceNews)
                }
            }
            .searchable(text: $searchViceNews, placement: .navigationBarDrawer(displayMode: .always), prompt: "Cari Berita Apa nich ?")
            
        }
    }
}

#Preview {
    ViceNewsView()
}
