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

    struct ViewModel {
        var movieImageURL: String
        var title: String
        var genres: String
        var overview: String
        var releaseDate: String
        var isFavorite: Bool
    }
}
