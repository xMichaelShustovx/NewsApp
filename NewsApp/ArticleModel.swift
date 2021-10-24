//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Michael Shustov on 24.10.2021.
//

import Foundation

protocol ArticleModelProtocol {
    
    func articlesRetrived(_ articles: [Article])
    
}

class ArticleModel {
    
    var delegate: ArticleModelProtocol?
    
    func getArticles() {
        
        // Fire off the request to the API
        
        
        // Parse the returned JSON into article instances and pass it back to the view controller with the protocol and delegate pattern
        delegate?.articlesRetrived([Article]())
    }
    
}
