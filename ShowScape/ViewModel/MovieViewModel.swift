//
//  MovieViewModel.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 20/08/2024.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    
    @Published var movies: [Result] = [] // Tableau vide de films qui sera rempli via les fonctions dans NetworkService.
    @Published var nowAiring: [Result] = []
    @Published var popular: [Result] = []
    @Published var movieCredits: MovieCredits? // Stocke les crédits du film sélectionné
    @Published var searchResults: [Result] = []
    
    private var cancellables = Set<AnyCancellable>()
    var currentPage = 1
    private var isLoading = false
    private var totalPages = 1
    
    init() {
        getNowPlaying(page: currentPage)
        getPopularPosts()
        getUpcomingPosts()
    }
    
    // Récupère les crédits d'un film spécifique par son identifiant
    func fetchMovieCredits(movieId: Int) {
        let apiKey = "9bef79e7f45606f938c28dce50e221b1"
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let credits = try JSONDecoder().decode(MovieCredits.self, from: data)
                DispatchQueue.main.async {
                    self.movieCredits = credits
                }
            } catch {
                print("Failed to decode credits: \(error)")
            }
        }.resume()
    }
    
    // Récupère les films actuellement diffusés
    func getNowPlaying(page: Int) {
        guard !isLoading && page <= totalPages else { return }
        isLoading = true
        
        NetworkService.shared.fetchNowPlayingsPosts(page: page)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print("Failed to fetch movies: \(error)")
                    self.isLoading = false
                }
            } receiveValue: { [weak self] newMovies in
                guard let self = self else { return }
                if page == 1 {
                    self.movies = newMovies // Remplace la liste par la première page
                } else {
                    self.movies.append(contentsOf: newMovies) // Ajoute les pages supplémentaires
                }
                self.currentPage = page
                self.totalPages = 100 // Mettez à jour ceci en fonction de la réponse de l'API (si disponible)
            }
            .store(in: &cancellables)
    }
    
    // Récupère les films populaires
    func getPopularPosts(page: Int = 1) {
        NetworkService.shared.fetchPopularPosts(page: page)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Fetch completed")
                case .failure(let error):
                    print("Failed to fetch movies: \(error)")
                }
            } receiveValue: { [weak self] movies in
                self?.popular = movies
            }
            .store(in: &cancellables)
    }
    
    // Récupère les films à venir
    private func getUpcomingPosts(page: Int = 1) {
        NetworkService.shared.fetchUpcomingPosts(page: page)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Fetch completed")
                case .failure(let error):
                    print("Failed to fetch movies: \(error)")
                }
            } receiveValue: { [weak self] movies in
                self?.nowAiring = movies
            }
            .store(in: &cancellables)
    }
    
    // Charge plus de films si nécessaire (scénario de défilement infini)
    //    func loadMoreMoviesIfNeeded(currentMovie: Result) {
    //        guard let lastMovie = movies.last else { return }
    //        if currentMovie.id == lastMovie.id {
    //            getNowPlaying(page: currentPage + 1)
    //        }
    //    }
    
    func loadMoreMoviesIfNeeded(currentMovie: Result, movies: [Result], loadMoreFunction: () -> Void) {
        guard let lastMovie = movies.last else { return }
        if currentMovie.id == lastMovie.id {
            loadMoreFunction()
        }
    }
    
    func searchMovies(query: String) {
        guard !query.isEmpty else {
            self.searchResults = []
            return
        }
        
        NetworkService.shared.searchMovies(query: query)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Search error: \(error)")
                }
            }, receiveValue: { [weak self] results in
                self?.searchResults = results
            })
            .store(in: &cancellables)
    }
}

