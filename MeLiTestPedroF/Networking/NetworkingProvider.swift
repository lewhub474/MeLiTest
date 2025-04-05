//
//  NetworkingProvider.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

final class NetworkingProvider {
    func fetchArticles(searchText: String?, completion: @escaping (Result<[Article], Error>) -> Void) {
        var urlString = "https://api.spaceflightnewsapi.net/v4/articles/?limit=20"
        
        if let search = searchText, !search.isEmpty {
            urlString += "&search=\(search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }

        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(ArticleResponse.self, from: data)
                    completion(.success(decoded.results))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
