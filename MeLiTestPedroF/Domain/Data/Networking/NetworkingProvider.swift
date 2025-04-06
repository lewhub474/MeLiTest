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

        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData 

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(ArticleResponse.self, from: data)
                completion(.success(decoded.results))
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
}
