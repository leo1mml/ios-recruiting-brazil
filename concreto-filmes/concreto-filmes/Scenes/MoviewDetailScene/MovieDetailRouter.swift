//
//  MovieDetailRouter.swift
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

@objc protocol MovieDetailRoutingLogic {
  
}

protocol MovieDetailDataPassing {
  var dataStore: MovieDetailDataStore? { get }
}

class MovieDetailRouter: NSObject, MovieDetailRoutingLogic, MovieDetailDataPassing {
  weak var viewController: MovieDetailViewController?
  var dataStore: MovieDetailDataStore?
}
