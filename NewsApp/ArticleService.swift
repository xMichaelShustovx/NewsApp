//
//  ArticleService.swift
//  NewsApp
//
//  Created by Michael Shustov on 24.10.2021.
//

import Foundation

struct ArticleService: Decodable {
    
    var totalResults: Int?
    var articles: [Article]?
    
}
