//
//  MainScreenInteractor.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 23/10/18.
//  Copyright (c) 2018 Leonel Menezes. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainScreenBusinessLogic
{
    func fetchPopularMovies(request: MainScreen.FetchPopularMovies.Request, isFirstRequest: Bool, completionBlock: (() -> ())?)
    func filterMoviesLocally(text: String)
    func fetchQueriedMovies(request: MainScreen.FetchQueryMovies.Request, isFirstRequest: Bool, completionBlock: (() -> ())?)
}

protocol MainScreenDataStore
{
    var movieTitle: String { get set }
    var movies: [Movie] { get set }
    var filteredMovies: [Movie] { get set }
}

class MainScreenInteractor: MainScreenBusinessLogic, MainScreenDataStore
{
    var presenter: MainScreenPresentationLogic?
    var worker = MainScreenWorker()
    var movieTitle: String = ""
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    
    func fetchPopularMovies(request: MainScreen.FetchPopularMovies.Request, isFirstRequest: Bool, completionBlock: (() -> ())?) {
        worker.fetchPopularMovies(request: request, completion: { (movies, error) in
            if(error != nil){
                self.presenter?.present(error: error)
            }
            if let movies = movies{
                if isFirstRequest {
                    self.movies = movies
                }else {
                    self.movies.append(contentsOf: movies)
                }
                self.presenter?.present(movies: self.movies)
                guard let completion = completionBlock else {return}
                completion()
            }
        })
    }
    
    func fetchQueriedMovies(request: MainScreen.FetchQueryMovies.Request, isFirstRequest: Bool, completionBlock: (() -> ())?) {
        worker.fetchMoviesByQuery(request: MainScreen.FetchQueryMovies.Request(index: request.index, text: request.text)) { (movies, error) in
            if(error != nil){
                self.presenter?.present(error: error)
            }
            if let movies = movies {
                if isFirstRequest {
                    self.filteredMovies = movies
                }else {
                    self.filteredMovies.append(contentsOf: movies)
                }
                self.presenter?.present(movies: self.filteredMovies)
            }
        }
    }
    
    
    func filterMoviesLocally(text: String) {
        if(text == ""){
            self.presenter?.present(movies: self.movies)
            return
        }
        let filteredMovies = movies.filter({ (movie) -> Bool in
            return movie.title.lowercased().contains(text.lowercased())
        })
        self.presenter?.present(movies: filteredMovies)
    }
}

