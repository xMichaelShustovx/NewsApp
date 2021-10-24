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

        // Create a string URL
        let stringUrl = "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=useYourOwnApiKey"
        
        // Create a URL object
        let url = URL(string: stringUrl)
        
        // Check that it isn't nil
        guard url != nil else {
            print("Couldn't create URL object")
            return
        }
        
        // Get the URL session
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                
                // Parse the JSON
                let decoder = JSONDecoder()
                
                do {
                    
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
                    
                    // Parse the returned JSON into article instances and pass it back to the view controller with the protocol and delegate pattern in the main thread
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrived(articleService.articles!)
                    }
                }
                catch {
                    print("Couldn't decode recived data")
                }
                
            }
        }
        
        // Start the data task
        dataTask.resume()
    }
}
