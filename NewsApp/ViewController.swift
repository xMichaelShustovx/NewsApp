//
//  ViewController.swift
//  NewsApp
//
//  Created by Michael Shustov on 24.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = ArticleModel()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the viewcontroller as the data source and delegate of the table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Get the articles from the article model
        model.delegate = self
        model.getArticles()
        
    }
}

// MARK: - Table View Protocol Methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // Customize the cell
        cell.displayArticle(articles[indexPath.row])
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Article Model Protocol Methods
extension ViewController: ArticleModelProtocol {
    
    func articlesRetrived(_ articles: [Article]) {
        
        // Set the articles property of the view controller to the articles passed back from the model
        self.articles = articles
        
        // Refresh the table view
        tableView.reloadData()
        
    }
    
}
