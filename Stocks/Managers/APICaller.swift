//
//  APICaller.swift
//  Stocks
//
//  Created by Yaroslav on 5.01.22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private struct Constants {
        static let apiKey = "c7ouu2aad3i94t1itn00"
        static let sandboxApiKey = "sandbox_c7ouu2aad3i94t1itn0g"
        static let baseUrl = "https://finnhub.io/api/v1/"
        static let day: TimeInterval = 60 * 60 * 24
    }
    
    private init() {}
    
    // MARK: - Public
    
    public func search(
        query: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        request(
            url: url(
                for: .search,
                   queryParams: ["q": query]
            ),
            expecting: SearchResponse.self,
            completion: completion
        )
        
    }
    
    public func news(
        for type: NewsViewController.`Type`,
        completion: @escaping (Result<[NewsStory], Error>) -> Void
    ) {
        
        switch type {
        case .topStories:
            request(
                url: url(for: .topStories, queryParams: ["category": "general"]),
                expecting: [NewsStory].self,
                completion: completion
            )
        case .company(let symbol):
            let today = Date()
            let oneMonthBack = today.addingTimeInterval(-(Constants.day * 7))
            request(
                url: url(
                    for: .companyNews,
                       queryParams: [
                        "symbol": symbol,
                        "from": DateFormatter.newsDateFormatter.string(from: oneMonthBack),
                        "to": DateFormatter.newsDateFormatter.string(from: today)
                       ]
                ),
                expecting: [NewsStory].self,
                completion: completion
            )
        }
    }
    
    // MARK: - Private
    
    private enum Endpoint: String {
        case search
        case topStories = "news"
        case companyNews = "company-news"
    }
    
    private enum APIError: Error {
        case noDataReturned
        case invalidUrl
    }
    
    private func url(
        for endpoint: Endpoint,
        queryParams: [String: String] = [:]
    ) -> URL? {
        
        var urlString = Constants.baseUrl + endpoint.rawValue
        
        var queryItems = [URLQueryItem]()
        // Add any parameters
        for(name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        //Add token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        //Convert query items to suffix string
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
        print("\n\(urlString)\n")
        
        return URL(string: urlString)
    }
    
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            // Invalid url
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil  else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}