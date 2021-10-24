//
//  Article.swift
//  NewsApp
//
//  Created by Michael Shustov on 24.10.2021.
//

import Foundation

struct Article: Decodable {
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
}
