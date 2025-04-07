//
//  TrendingViewModel.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 29/05/2024.
//

import Foundation
import Combine

// ViewModel to handle networking and data flow
class NetworkService {
    
    static let shared = NetworkService()
    
    private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YmVmNzllN2Y0NTYwNmY5MzhjMjhkY2U1MGUyMjFiMSIsIm5iZiI6MTcyMjk1NDA2OC42NjQ1NSwic3ViIjoiNjA5Mjk0ODAzZjhlZGUwMDU4YTIyY2Y1Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.JKkS32UCE0UOkGqDTtohYrONGsX2jQGsZrK6fiHrTXA"
    
    func fetchNowPlayingsPosts(page: Int) -> AnyPublisher<[Result], Error> {
        
        var components = URLComponents(string: "https://api.themoviedb.org/3/trending/all/day")!
            components.queryItems = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ResultModel.self, decoder: JSONDecoder())
            .map { trendingModel in
                return trendingModel.results ?? []
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchPopularPosts(page: Int) -> AnyPublisher<[Result], Error> {
      
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/top_rated")!
            components.queryItems = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)")
            ]

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ResultModel.self, decoder: JSONDecoder())
            .map { trendingModel in
                return trendingModel.results ?? []
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetchUpcomingPosts(page: Int) -> AnyPublisher<[Result], Error> {
        
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/upcoming")!
            components.queryItems = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)")
            ]

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ResultModel.self, decoder: JSONDecoder())
            .map { trendingModel in
                return trendingModel.results ?? []
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func searchMovies(query: String) -> AnyPublisher<[Result], Error> {
        var components = URLComponents(string: "https://api.themoviedb.org/3/search/multi")!
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "include_adult", value: "false")
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ResultModel.self, decoder: JSONDecoder())
            .map { $0.results ?? [] }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    
}
