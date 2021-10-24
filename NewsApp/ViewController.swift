//
//  ViewController.swift
//  NewsApp
//
//  Created by Michael Shustov on 24.10.2021.
//

import UIKit

class ViewController: UIViewController {

    var model = ArticleModel()
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the articles from the article model
        model.delegate = self
        model.getArticles()
        
    }
}

// MARK: - Article Model Protocol Methods
extension ViewController: ArticleModelProtocol {
    
    func articlesRetrived(_ articles: [Article]) {
        print("Articles returned from model")
    }
    
}
