//
//  TrendingModel.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 29/05/2024.
//

import Foundation

// MARK: - TrendingModel
struct ResultModel: Codable {
    let dates: Dates?
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates: Codable {
    let maximum, minimum: String?
}

struct Result: Codable, Identifiable, Hashable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var posterPathImage: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w300\(posterPath ?? "")")
    }
}


struct Actor: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let profilePath: String?
}

struct MovieCredits: Codable {
    let cast: [Actor]
}





