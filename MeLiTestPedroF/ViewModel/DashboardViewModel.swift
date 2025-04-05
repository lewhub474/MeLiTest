//
//  DashboardViewModel.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

final class DashboardViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var searchText: String = ""
    @Published var isLoading = false

    func fetchArticles() {
        isLoading = true

        var urlString = "https://api.spaceflightnewsapi.net/v4/articles/?limit=20"

        if !searchText.isEmpty {
            urlString += "&search=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }

        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }

        print("Fetching: \(url)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(ArticleResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = decoded.results
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            } else if let error = error {
                print("Fetch error: \(error)")
            }
        }.resume()
    }
}
