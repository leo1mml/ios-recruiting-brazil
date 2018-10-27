//
//  MovieDetailModels.swift
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
import Keys

enum MovieDetail {
    // MARK: Use cases

    enum FetchMovieGenres {
        struct Request {
            var baseUrl: String = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(ConcretoFilmesKeys().tHE_MOVIE_DB_V3_KEY)&language=\(Locale.preferredLanguages[0] as String)"
        }
    }

    struct ViewModel {
        var movieImage: UIImage
        var title: String
        var genres: [String]?
        var overview: String
        var isFavorite: Bool
    }
}
