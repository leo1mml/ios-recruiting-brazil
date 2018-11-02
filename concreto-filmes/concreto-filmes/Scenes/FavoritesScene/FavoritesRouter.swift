//
//  FavoritesRouter.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 31/10/18.
//  Copyright (c) 2018 Leonel Menezes. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RealmSwift

@objc protocol FavoritesRoutingLogic {
    func routeToMovieDetail(shouldFilter: Bool, index: Int)
    func routeToFilterScene()
}

protocol FavoritesDataPassing {
    var dataStore: FavoritesDataStore? { get }
}

class FavoritesRouter: NSObject, FavoritesRoutingLogic, FavoritesDataPassing {
    weak var viewController: FavoritesViewController?
    var dataStore: FavoritesDataStore?
    let realm = RealmService.shared.realm
    // MARK: Routing
    
    func routeToMovieDetail(shouldFilter: Bool, index: Int) {
        guard let sourceVC = viewController else { return }
        if let dataStore = self.dataStore {
            let movie = shouldFilter ? dataStore.filteredMovies[index] : dataStore.movies[index]
            let isFavorite = self.realm?.object(ofType: MovieRealm.self, forPrimaryKey: movie.id) != nil
            let destinationVC = MovieDetailViewController(viewModel: MovieDetail.ViewModel(movieImageURL: movie.posterPath, title: movie.title, genres: movie.genresString(), overview: movie.overview, releaseDate: movie.yearString(), isFavorite: isFavorite))
            guard var destinationDS = destinationVC.router?.dataStore else { return }
            passDataToDetailVC(source: dataStore, destination: &destinationDS, index: index, shouldFilter: shouldFilter)
            navigateToMovieDetail(source: sourceVC, destination: destinationVC)
        }
    }
    
    func passDataToDetailVC(source: FavoritesDataStore, destination: inout MovieDetailDataStore, index: Int, shouldFilter: Bool) {
        destination.movie = shouldFilter ? source.filteredMovies[index] : source.movies[index]
    }
    
    func navigateToMovieDetail(source: FavoritesViewController, destination: MovieDetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func routeToFilterScene() {
        guard let sourceVC = viewController else { return }
        if let dataStore = self.dataStore {
            let destinationVC = FilterViewController()
            guard var destinationDS = destinationVC.router?.dataStore else { return }
            passDataToFilterScene(source: dataStore, destination: &destinationDS)
            navigateToFilterScene(source: sourceVC, destination: destinationVC)
        }
    }
    
    func passDataToFilterScene(source: FavoritesDataStore, destination: inout FilterDataStore) {
        destination.genres = Genre.fetchedGenres.map { "\($0.value)" }
        destination.years = source.movies.map { (movie) -> String in
            return movie.yearString()
        }.unique.sorted()
    }
    
    func navigateToFilterScene(source: FavoritesViewController, destination: FilterViewController) {
        source.present(destination, animated: true, completion: nil)
    }
}
